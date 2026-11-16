import 'package:flutter/material.dart';

/// One choice shown as a tappable card with a radio dot.
class ChoiceOption<T> {
  final T value;
  final IconData icon;
  final String label;
  final String? desc;
  const ChoiceOption(this.value, this.icon, this.label, [this.desc]);
}

/// Options shown side by side as CARDS (no dropdown). The user taps the dot/card he wants.
class ChoiceCards<T> extends StatelessWidget {
  final T value;
  final List<ChoiceOption<T>> options;
  final ValueChanged<T> onChanged;
  const ChoiceCards({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final o in options)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: _OptionCard(
                  option: o,
                  selected: o.value == value,
                  onTap: () => onChanged(o.value),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _OptionCard<T> extends StatelessWidget {
  final ChoiceOption<T> option;
  final bool selected;
  final VoidCallback onTap;
  const _OptionCard({required this.option, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      selected: selected,
      label: option.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.fromLTRB(6, 10, 6, 10),
          decoration: BoxDecoration(
            color: selected ? cs.primary.withValues(alpha: 0.10) : cs.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? cs.primary : cs.outlineVariant,
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(option.icon, size: 22, color: selected ? cs.primary : cs.onSurfaceVariant),
              const SizedBox(height: 6),
              Text(
                option.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: selected ? cs.primary : cs.onSurface,
                ),
              ),
              if (option.desc != null) ...[
                const SizedBox(height: 3),
                Text(
                  option.desc!,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10.5, color: cs.onSurfaceVariant),
                ),
              ],
              const Spacer(),
              const SizedBox(height: 8),
              // the radio dot
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: selected ? cs.primary : cs.outline, width: 2),
                ),
                child: selected
                    ? Center(
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: cs.primary),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A titled settings card with an optional on/off switch; [child] shows only when on.
class SettingCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool? enabled;
  final ValueChanged<bool>? onToggle;
  final Widget? child;
  const SettingCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.enabled,
    this.onToggle,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final on = enabled ?? true;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: on ? cs.surface : cs.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: on ? cs.primary.withValues(alpha: 0.3) : cs.outlineVariant.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 8, 8),
            child: Row(
              children: [
                Icon(icon, color: on ? cs.primary : cs.onSurfaceVariant),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: on ? cs.onSurface : cs.onSurfaceVariant)),
                      if (subtitle != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(subtitle!,
                              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                        ),
                    ],
                  ),
                ),
                if (onToggle != null)
                  Switch(
                    value: on,
                    onChanged: onToggle,
                    activeColor: cs.surface,
                    activeTrackColor: cs.primary,
                  ),
              ],
            ),
          ),
          if (on && child != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 14),
              child: child,
            ),
        ],
      ),
    );
  }
}

/// Row of selectable pills (minutes presets etc.).
class PillRow<T> extends StatelessWidget {
  final T value;
  final List<T> values;
  final String Function(T) label;
  final ValueChanged<T> onChanged;
  const PillRow({
    super.key,
    required this.value,
    required this.values,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final v in values)
          InkWell(
            onTap: () => onChanged(v),
            borderRadius: BorderRadius.circular(10),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: v == value ? cs.primary : cs.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: v == value ? cs.primary : cs.primary.withValues(alpha: 0.2)),
              ),
              child: Text(
                label(v),
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: v == value ? FontWeight.bold : FontWeight.w500,
                  color: v == value ? cs.onPrimary : cs.onSurface,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
