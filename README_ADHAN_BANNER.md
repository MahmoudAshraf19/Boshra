# شريط الأذان (Adhan Banner) — دليل التركيب

انسخ المجلدات `lib/` و `android/` و `assets/` فوق مشروعك (نفس المسارات، الملفات الموجودة هتتبدّل).

## 1) pubspec.yaml (لازم يدوي)
```yaml
flutter:
  assets:
    - assets/fonts/        # لو مش مضاف أصلاً
  fonts:
    - family: ArefRuqaa
      fonts:
        - asset: assets/fonts/ArefRuqaa-Regular.ttf
        - asset: assets/fonts/ArefRuqaa-Bold.ttf
          weight: 700
```
(بقية الخطوط عندك زي ما هي. الخط Aref Ruqaa ترخيص OFL مجاني، ونسخة الترخيص في `assets/fonts/ArefRuqaa-OFL.txt`.)

## 2) أوامر
```
flutter pub get
flutter gen-l10n        # اختياري: الملفات المولّدة متعدّلة بالفعل
flutter clean && flutter run
```
> مهم: قنوات الإشعارات في أندرويد بتتثبّت أول ما تتعمل. الملفات مش بتغيّر القنوات، فمفيش حاجة تتمسح. لكن لازم **تعمل uninstall/install مرة** أو على الأقل Build جديد عشان الـ drawables الجديدة (`ic_stat_adhan`, `adhan_large_icon`) تدخل الـ APK. لو الـ drawables مش موجودة، كل الإشعارات هتفشل (invalid_icon).

## 3) اللي اتضاف/اتعدّل
| الملف | الغرض |
|---|---|
| `core/notifications/adhan_notification_actions.dart` | زر «إيقاف الأذان» (يشتغل والتطبيق مقفول/الفون مقفول) |
| `core/services/notification_service.dart` | زر الإيقاف + أيقونة صغيرة/كبيرة + لون + نص موسّع |
| `core/notifications/adhan_banner_controller.dart` | التحكم في الشريط داخل التطبيق |
| `core/widgets/adhan_banner.dart` / `adhan_banner_host.dart` | التصميم الإسلامي للشريط + طبقة العرض فوق كل الشاشات |
| `features/prayer/domain/prayer_settings.dart` | إعداد جديد `adhanBanner` (الافتراضي: مفعّل) |
| `features/prayer/domain/prayer_scheduler_service.dart` | تمرير الزر والآية لإشعارات الأذان |
| `features/prayer/presentation/screens/prayer_settings_screen.dart` | سويتش الخيار + معاينة حيّة |
| `main.dart`, `notification_coordinator.dart` | ربط الشريط بالتطبيق |
| `l10n/*` | 5 نصوص جديدة × 8 لغات (ar, en, es, fa, fr, hi, it, ur) |
| `AndroidManifest.xml` | `ActionBroadcastReceiver` (ضروري لزر الإشعار) |
| `res/raw/keep.xml` | منع حذف الأيقونات الجديدة في الـ release (shrinkResources) |
| `res/drawable/ic_stat_adhan.xml`, `res/drawable-nodpi/adhan_large_icon.png` | أيقونة الهلال |

## 4) إضافة لغة جديدة
أضف `app_xx.arb` بنفس الـ 5 مفاتيح: `adhanStopAction, adhanBannerTitle, adhanBannerDesc, adhanBannerPreview, adhanBannerVerse` ثم `flutter gen-l10n`.

## 5) اختبار لازم تعمله على جهاز حقيقي
1. اضبط وقت الجهاز أو استنى صلاة، والتطبيق **مفتوح** → الشريط الإسلامي ينزل من فوق + زر الإيقاف.
2. التطبيق **مقفول (swipe)** → إشعار Heads-up من فوق + زر «إيقاف الأذان» → الصوت يقف.
3. الفون **مقفول** → الإشعار يظهر على شاشة القفل بنفس الزر.
4. من الإعدادات: اقفل «شريط الأذان العلوي» → الزر يختفي (الأذان يشتغل عادي).
5. جرّب على Xiaomi/Oppo/Samsung (بيقتلوا الخلفية) وAndroid 13/14/15.

## 6) توافق سياسات Google Play (قائمة مراجعة)
- ✅ لا `USE_FULL_SCREEN_INTENT` (مقيّد لتطبيقات المكالمات/المنبّه وممكن يتسبب في رفض).
- ✅ لا Foreground Service جديدة للأذان؛ الصوت من قناة الإشعار نفسها.
- ✅ `POST_NOTIFICATIONS` بيتطلب بشاشة شرح قبل الطلب (موجودة عندك في أول تشغيل).
- ⚠️ `SCHEDULE_EXACT_ALARM`: لازم تملأ **Exact alarm declaration** في Play Console وتذكر إن مواقيت الصلاة هي الوظيفة الأساسية. (مش بنستخدم `USE_EXACT_ALARM`.)
- ⚠️ Data safety + Privacy Policy لازم تغطي الموقع (بتستخدمه للمواقيت).
- ⚠️ `usesCleartextTraffic="true"` موجود عندك عشان الراديو؛ مش سبب رفض لكن يفضّل تحصره في domains محددة.
- 🔐 الـ zip اللي رفعته فيه `key.properties` و `boshra-upload-key.jks` — غيّر الباسوردات/الـ upload key لو الملفات اتشاركت.

## 7) حدود أندرويد (مفيش طريقة تتخطاها)
- شكل الإشعار الخارجي بيرسمه النظام: بنتحكم في الأيقونة واللون والنص والزر، لكن مش في الخط/الخلفية. التصميم الإسلامي الكامل (الخط المخصص والزخرفة) في الشريط داخل التطبيق وفي المعاينة.
- بدون Full-screen intent، الشاشة المقفولة مش بتتفتح بالقوة؛ الإشعار بيظهر على شاشة القفل والصوت بيشتغل.
- بعد «Force stop» من المستخدم، كل المنبّهات بتتلغي لحد ما التطبيق يتفتح مرة.
