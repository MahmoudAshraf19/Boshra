import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/utils/date_text.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/notifications/notification_coordinator.dart';
import '../../../../core/services/telemetry.dart';
import '../../data/metal_prices_service.dart';
import '../../data/zakat_settings.dart';

/// Zakat calculator with gold / silver prices in the user's currency and a yearly reminder.
/// General guidance only — the dialog tells the user to ask a scholar for special cases.
class ZakatScreen extends StatefulWidget {
  const ZakatScreen({super.key});

  @override
  State<ZakatScreen> createState() => _ZakatScreenState();
}

class _ZakatScreenState extends State<ZakatScreen> {
  static const _fields = ['cash', 'g24', 'g21', 'g18', 'silver', 'invest', 'trade', 'owed', 'debts'];

  final Map<String, TextEditingController> _c = {for (final k in _fields) k: TextEditingController()};
  ZakatSettings _s = const ZakatSettings(currency: 'USD', nisab: 'gold', remind: false, hawlStart: null);
  MetalPrices? _prices;
  double? _manualG24;
  double? _manualSilver;
  bool _loading = true;
  bool _refreshing = false;
  Timer? _saveDebounce;

  bool get _ar => Localizations.localeOf(context).languageCode == 'ar';
  String t(String ar, String en) => _ar ? ar : en;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  @override
  void dispose() {
    _saveDebounce?.cancel();
    for (final c in _c.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _init() async {
    final s = await ZakatSettings.load();
    final inputs = await ZakatSettings.loadInputs();
    for (final k in _fields) {
      _c[k]!.text = inputs[k] ?? '';
    }
    final cached = await MetalPricesService().cached();
    if (!mounted) return;
    setState(() {
      _s = s;
      _prices = cached;
      _loading = false;
    });
    await _loadManual();
    _refresh();
  }

  Future<void> _loadManual() async {
    final p = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _manualG24 = p.getDouble('zakat_manual_g24_${_s.currency}');
      _manualSilver = p.getDouble('zakat_manual_s_${_s.currency}');
    });
  }

  Future<void> _refresh() async {
    setState(() => _refreshing = true);
    final p = await MetalPricesService().fetch();
    if (!mounted) return;
    setState(() {
      _prices = p ?? _prices;
      _refreshing = false;
    });
  }

  // ------------------------------------------------------------------ numbers
  double _n(String key) {
    var s = _c[key]!.text.trim();
    if (s.isEmpty) return 0;
    const ar = '٠١٢٣٤٥٦٧٨٩';
    for (var i = 0; i < 10; i++) {
      s = s.replaceAll(ar[i], '$i');
    }
    s = s.replaceAll('٫', '.').replaceAll('٬', '').replaceAll(',', '');
    return double.tryParse(s) ?? 0;
  }

  double? get _g24 => _manualG24 ?? _prices?.gram24(_s.currency);
  double? get _silverG => _manualSilver ?? _prices?.silverGram(_s.currency);

  double get _goldValue {
    final g = _g24;
    if (g == null) return 0;
    return g * (_n('g24') + _n('g21') * 21 / 24 + _n('g18') * 18 / 24);
  }

  double get _silverValue => (_silverG ?? 0) * _n('silver');

  double get _total =>
      _n('cash') + _goldValue + _silverValue + _n('invest') + _n('trade') + _n('owed') - _n('debts');

  double? get _nisabValue {
    final g = _s.nisab == 'gold' ? _g24 : _silverG;
    return g == null ? null : g * (_s.nisab == 'gold' ? 85 : 595);
  }

  String _fmt(double v) => NumberFormat('#,##0.##', 'en').format(v);

  void _changed() {
    setState(() {});
    _saveDebounce?.cancel();
    _saveDebounce = Timer(const Duration(milliseconds: 600), () {
      ZakatSettings.saveInputs({for (final k in _fields) k: _c[k]!.text});
    });
  }

  Future<void> _saveSettings(ZakatSettings n) async {
    setState(() => _s = n);
    await n.save();
    NotificationCoordinator.instance.rescheduleAll(force: true); // yearly reminder
  }

  Future<void> _editPrices() async {
    final cur = _s.currency;
    final g = TextEditingController(text: _manualG24?.toStringAsFixed(2) ?? '');
    final s = TextEditingController(text: _manualSilver?.toStringAsFixed(2) ?? '');
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t('أسعار محلية يدوية ($cur)', 'Manual local prices ($cur)')),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            t('سعر جرام السوق عندك قد يختلف عن السعر العالمي (علاوة الصاغة وفرق سعر الصرف). اكتب سعر الجرام من محلات الصاغة لو حبيت. اتركه فارغًا لاستخدام السعر التلقائي.',
                'Your local jeweller price may differ from the world price. Enter your own per-gram price, or leave empty to use the automatic one.'),
            style: const TextStyle(fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: g,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: t('جرام الذهب عيار 24', 'Gold 24k per gram')),
          ),
          TextField(
            controller: s,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: t('جرام الفضة', 'Silver per gram')),
          ),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(t('إلغاء', 'Cancel'))),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(t('حفظ', 'Save'))),
        ],
      ),
    );
    if (ok != true) return;
    final p = await SharedPreferences.getInstance();
    final gv = double.tryParse(g.text.replaceAll(',', '.'));
    final sv = double.tryParse(s.text.replaceAll(',', '.'));
    gv == null ? await p.remove('zakat_manual_g24_$cur') : await p.setDouble('zakat_manual_g24_$cur', gv);
    sv == null ? await p.remove('zakat_manual_s_$cur') : await p.setDouble('zakat_manual_s_$cur', sv);
    await _loadManual();
  }

  Future<void> _pickHawl() async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: _s.hawlStart ?? now,
      firstDate: DateTime(now.year - 3),
      lastDate: now,
      helpText: t('تاريخ ما بلغ مالك النصاب', 'Date your wealth reached the nisab'),
    );
    if (d != null) _saveSettings(_s.copyWith(hawlStart: d, remind: true));
  }

  String _summary() {
    final total = _total;
    final nv = _nisabValue;
    final due = (nv != null && total >= nv) ? total * 0.025 : 0.0;
    final cur = _s.currency;
    return t(
      'زكاة المال — بُشرى\nإجمالي المال الخاضع للزكاة: ${_fmt(total)} $cur\nالنصاب (${_s.nisab == 'gold' ? '85 جم ذهب' : '595 جم فضة'}): ${nv == null ? '—' : _fmt(nv)} $cur\nالزكاة الواجبة (2.5%): ${_fmt(due)} $cur',
      'Zakat — Boshra\nZakatable wealth: ${_fmt(total)} $cur\nNisab (${_s.nisab == 'gold' ? '85 g gold' : '595 g silver'}): ${nv == null ? '—' : _fmt(nv)} $cur\nZakat due (2.5%): ${_fmt(due)} $cur',
    );
  }

  Widget _field(String key, String label, {String? hint, String? suffix}) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextField(
          controller: _c[key],
          onChanged: (_) => _changed(),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9٠-٩.,٫٬]'))],
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            suffixText: suffix,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            isDense: true,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final cur = _s.currency;
    final total = _total;
    final nv = _nisabValue;
    final reached = nv != null && total >= nv;
    final due = reached ? total * 0.025 : 0.0;
    final nextDue = _s.nextDue(DateTime.now());
    final p = _prices;
    final stale = p != null && DateTime.now().difference(p.fetchedAt) > const Duration(days: 2);

    return Scaffold(
      appBar: AppBar(title: Text(t('حاسبة الزكاة', 'Zakat calculator'))),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // ---- currency
                Row(children: [
                  Expanded(
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: t('العملة', 'Currency'),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                        isDense: true,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          isDense: true,
                          value: Currencies.all.any((e) => e.code == cur) ? cur : 'USD',
                          items: [
                            for (final c in Currencies.all)
                              DropdownMenuItem(value: c.code, child: Text('${c.code} — ${c.name(_ar)}')),
                          ],
                          onChanged: (v) async {
                            if (v == null) return;
                            await _saveSettings(_s.copyWith(currency: v));
                            await _loadManual();
                          },
                        ),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 12),
                // ---- prices
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(18)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      const Icon(Icons.show_chart_rounded),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(t('أسعار اليوم (للجرام)', "Today's prices (per gram)"),
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      if (_refreshing)
                        const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      else
                        IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh_rounded), tooltip: t('تحديث', 'Refresh')),
                      IconButton(onPressed: _editPrices, icon: const Icon(Icons.edit_rounded), tooltip: t('تعديل يدوي', 'Edit manually')),
                    ]),
                    if (_g24 == null)
                      Text(t('تعذّر جلب الأسعار (لا إنترنت). اضغط ✏️ لإدخال سعر الجرام يدويًا.',
                          'Could not load prices (offline). Tap ✏️ to enter the per-gram price.'),
                          style: TextStyle(color: cs.error, fontSize: 13))
                    else ...[
                      _priceRow(t('ذهب عيار 24', 'Gold 24k'), _g24!, cur),
                      _priceRow(t('ذهب عيار 21', 'Gold 21k'), _g24! * 21 / 24, cur),
                      _priceRow(t('ذهب عيار 18', 'Gold 18k'), _g24! * 18 / 24, cur),
                      if (_silverG != null) _priceRow(t('فضة', 'Silver'), _silverG!, cur),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      (_manualG24 != null || _manualSilver != null)
                          ? t('✏️ تستخدم أسعارك اليدوية', '✏️ Using your manual prices')
                          : p == null
                              ? ''
                              : t('سعر عالمي × سعر الصرف — محدّث ${DateText.shortStamp(p.fetchedAt)}${stale ? ' (قديم)' : ''}',
                                  'World price × exchange rate — updated ${DateText.shortStamp(p.fetchedAt)}${stale ? ' (old)' : ''}'),
                      style: TextStyle(fontSize: 11.5, color: stale ? cs.error : cs.onSurfaceVariant),
                    ),
                  ]),
                ),
                const SizedBox(height: 14),
                // ---- nisab type
                Text(t('النصاب', 'Nisab'), style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                SegmentedButton<String>(
                  segments: [
                    ButtonSegment(value: 'gold', label: Text(t('ذهب (85 جم)', 'Gold (85 g)'))),
                    ButtonSegment(value: 'silver', label: Text(t('فضة (595 جم)', 'Silver (595 g)'))),
                  ],
                  selected: {_s.nisab},
                  onSelectionChanged: (v) => _saveSettings(_s.copyWith(nisab: v.first)),
                ),
                const SizedBox(height: 4),
                Text(
                  t('اعتمد النصاب الذي تفتي به الجهة التي تثق بها (دار الإفتاء في بلدك). نصاب الفضة أقل قيمة فيشمل عددًا أكبر من الناس.',
                      'Use the nisab your trusted scholarly authority uses. The silver nisab is lower in value, so it covers more people.'),
                  style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, height: 1.4),
                ),
                const SizedBox(height: 16),
                // ---- inputs
                Text(t('أموالك', 'Your wealth'), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _field('cash', t('النقد والمدخرات والحسابات البنكية', 'Cash, savings & bank accounts'), suffix: cur),
                _field('g24', t('ذهب عيار 24', 'Gold 24k'), suffix: t('جرام', 'g')),
                _field('g21', t('ذهب عيار 21', 'Gold 21k'), suffix: t('جرام', 'g')),
                _field('g18', t('ذهب عيار 18', 'Gold 18k'), suffix: t('جرام', 'g')),
                _field('silver', t('فضة', 'Silver'), suffix: t('جرام', 'g')),
                _field('invest', t('أسهم واستثمارات وصناديق', 'Shares & investments'), suffix: cur),
                _field('trade', t('بضاعة تجارة (بسعر السوق)', 'Trade goods (market value)'), suffix: cur),
                _field('owed', t('ديون لك مضمونة السداد', 'Money owed to you (reliable)'), suffix: cur),
                _field('debts', t('ديون عليك مستحقة الآن (تُخصم)', 'Debts you owe now (deducted)'), suffix: cur),
                Text(
                  t('اختلف العلماء في زكاة الحلي المستعمل للزينة؛ الحاسبة تحسبه، فإن كان رأي من تقلّده عدم الزكاة فيه فاترك خانات الذهب فارغة.',
                      'Scholars differ on zakat for worn jewellery; it is counted here — leave the gold fields empty if you follow the other view.'),
                  style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, height: 1.4),
                ),
                const SizedBox(height: 18),
                // ---- result
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: LinearGradient(
                      colors: reached
                          ? [Colors.green.shade700, Colors.green.shade500]
                          : [cs.primary.withValues(alpha: 0.85), cs.primary.withValues(alpha: 0.6)],
                    ),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(t('إجمالي المال الخاضع للزكاة', 'Total zakatable wealth'), style: const TextStyle(color: Colors.white70)),
                    Text('${_fmt(total)} $cur', style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      nv == null
                          ? t('أدخل سعر الذهب/الفضة لحساب النصاب', 'Enter the gold/silver price to compute the nisab')
                          : t('النصاب: ${_fmt(nv)} $cur', 'Nisab: ${_fmt(nv)} $cur'),
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const Divider(color: Colors.white24, height: 22),
                    if (nv == null)
                      const SizedBox.shrink()
                    else if (reached) ...[
                      Text(t('الزكاة الواجبة (2.5%)', 'Zakat due (2.5%)'), style: const TextStyle(color: Colors.white70)),
                      Text('${_fmt(due)} $cur', style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(t('بشرط أن يمرّ على مالك حَوْل كامل (سنة هجرية).', 'Provided a full lunar year has passed over it.'),
                          style: const TextStyle(color: Colors.white70, fontSize: 12.5)),
                    ] else
                      Text(
                        t('لم يبلغ مالك النصاب (ينقصك ${_fmt(nv - total)} $cur) فلا زكاة عليك الآن.',
                            'Below the nisab (${_fmt(nv - total)} $cur short) — no zakat is due now.'),
                        style: const TextStyle(color: Colors.white, height: 1.4),
                      ),
                  ]),
                ),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: _summary()));
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t('تم نسخ النتيجة', 'Result copied'))));
                        Telemetry.log('zakat_copy');
                      },
                      icon: const Icon(Icons.copy_rounded),
                      label: Text(t('نسخ النتيجة', 'Copy result')),
                    ),
                  ),
                ]),
                const SizedBox(height: 18),
                // ---- yearly reminder
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: cs.surfaceContainerLow, borderRadius: BorderRadius.circular(18)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      const Icon(Icons.event_repeat_rounded),
                      const SizedBox(width: 8),
                      Expanded(child: Text(t('تذكير سنوي بالزكاة', 'Yearly zakat reminder'), style: const TextStyle(fontWeight: FontWeight.bold))),
                      Switch(
                        value: _s.remind && _s.hawlStart != null,
                        onChanged: (v) async {
                          if (v && _s.hawlStart == null) {
                            await _pickHawl();
                          } else {
                            await _saveSettings(_s.copyWith(remind: v));
                          }
                        },
                      ),
                    ]),
                    Text(
                      t('اختر تاريخ ما بلغ مالك النصاب، وسنذكّرك قبل تمام الحول بأسبوع ويوم تمامه كل عام (سنة قمرية تقريبية 354 يومًا).',
                          'Pick the date your wealth reached the nisab. We remind you a week before the lunar year completes and on the day, every year (≈354 days).'),
                      style: TextStyle(fontSize: 12.5, color: cs.onSurfaceVariant, height: 1.4),
                    ),
                    const SizedBox(height: 8),
                    Wrap(spacing: 8, crossAxisAlignment: WrapCrossAlignment.center, children: [
                      OutlinedButton.icon(
                        onPressed: _pickHawl,
                        icon: const Icon(Icons.calendar_month_rounded),
                        label: Text(_s.hawlStart == null
                            ? t('تحديد التاريخ', 'Set date')
                            : DateText.date(_s.hawlStart!, _ar)),
                      ),
                      if (nextDue != null && _s.remind)
                        Text(t('الحَوْل القادم: ${DateText.date(nextDue, true)}',
                            'Next due: ${DateText.date(nextDue, false)}')),
                    ]),
                  ]),
                ),
                const SizedBox(height: 14),
                Text(
                  t('تنبيه: الحاسبة للإرشاد العام. للحالات الخاصة (أسهم، شركات، ديون، عقارات للتجارة…) راجع أهل العلم في بلدك.',
                      'Note: general guidance only. For special cases (stocks, companies, debts, trade property…) ask a scholar.'),
                  style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, height: 1.4),
                ),
                const SizedBox(height: 24),
              ],
            ),
    );
  }

  Widget _priceRow(String label, double v, String cur) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(children: [
          Expanded(child: Text(label)),
          Text('${_fmt(v)} $cur', style: const TextStyle(fontWeight: FontWeight.bold)),
        ]),
      );
}
