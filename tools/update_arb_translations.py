# -*- coding: utf-8 -*-
"""
Script to add all localization keys for Sadaqa, Diagnostics, Zakat, and Tracker
to all 8 supported arb files in Boshra app:
en, ar, ur, fa, fr, es, it, hi
"""

import json
import os

TRANSLATIONS = {
    # ------------------ Sadaqa Jariya ------------------
    "sadaqaJariyaTitle": {
        "en": "Ongoing Charity",
        "ar": "صدقة جارية",
        "ur": "صدقۂ جاریہ",
        "fa": "صدقه جاریه",
        "fr": "Aumône continue (Sadaqa Jariya)",
        "es": "Caridad continua (Sadaqa Yariya)",
        "it": "Carità continua (Sadaqa Jariya)",
        "hi": "सदक़ा-ए-जारिया (जारी सदक़ा)"
    },
    "sadaqaHadith": {
        "en": "“Whoever guides someone to goodness will have a reward like one who did it.”",
        "ar": "«مَنْ دَلَّ عَلَى خَيْرٍ فَلَهُ مِثْلُ أَجْرِ فَاعِلِهِ»",
        "ur": "«جس نے کسی نیکی کی رہنمائی کی اسے نیکی کرنے والے کے برابر اجر ملے گا»",
        "fa": "«هر که به کار خیری راهنمایی کند، پاداشی همانند انجام‌دهنده آن دارد»",
        "fr": "« Celui qui guide vers un bien a la même récompense que celui qui l'a accompli. »",
        "es": "«Quien guía hacia el bien tendrá una recompensa como la de quien lo hace.»",
        "it": "«Chi guida verso il bene avrà una ricompensa pari a chi lo compie.»",
        "hi": "«जो किसी को भलाई की राह दिखाता है, उसे भलाई करने वाले जितना ही सवाब मिलता है»"
    },
    "narratedByMuslim": {
        "en": "Narrated by Muslim",
        "ar": "رواه مسلم",
        "ur": "روایت: مسلم",
        "fa": "روایت از مسلم",
        "fr": "Rapporté par Mouslim",
        "es": "Transmitido por Muslim",
        "it": "Riportato da Muslim",
        "hi": "हदीस: सहीह मुस्लिम"
    },
    "yourInviteCode": {
        "en": "Your invite code",
        "ar": "كود الدعوة الخاص بك",
        "ur": "آپ کا دعوتی کوڈ",
        "fa": "کد دعوت شما",
        "fr": "Votre code d'invitation",
        "es": "Tu código de invitación",
        "it": "Il tuo codice invito",
        "hi": "आपका इनवाइट कोड"
    },
    "codeCopied": {
        "en": "Code copied",
        "ar": "تم نسخ الكود",
        "ur": "کوڈ کاپی ہو گیا",
        "fa": "کد کپی شد",
        "fr": "Code copié",
        "es": "Código copiado",
        "it": "Codice copiato",
        "hi": "कोड कॉपी हो गया"
    },
    "shareAppButton": {
        "en": "Share the app",
        "ar": "شارك التطبيق",
        "ur": "ایپ شیئر کریں",
        "fa": "اشتراک‌گذاری برنامه",
        "fr": "Partager l'application",
        "es": "Compartir la aplicación",
        "it": "Condividi l'applicazione",
        "hi": "ऐप शेयर करें"
    },
    "shareViaWhatsApp": {
        "en": "Share via WhatsApp",
        "ar": "مشاركة عبر واتساب",
        "ur": "واٹس ایپ پر شیئر کریں",
        "fa": "اشتراک‌گذاری از طریق واتس‌اپ",
        "fr": "Partager via WhatsApp",
        "es": "Compartir por WhatsApp",
        "it": "Condividi via WhatsApp",
        "hi": "व्हाट्सएप पर शेयर करें"
    },
    "startFirstShare": {
        "en": "Make your first share 🌱",
        "ar": "ابدأ أول مشاركة لك 🌱",
        "ur": "اپنی پہلی شیئرنگ شروع کریں 🌱",
        "fa": "اولین اشتراک‌گذاری خود را آغاز کنید 🌱",
        "fr": "Faites votre premier partage 🌱",
        "es": "Haz tu primer envío 🌱",
        "it": "Fai la tua prima condivisione 🌱",
        "hi": "अपनी पहली शेयरिंग शुरू करें 🌱"
    },
    "sharedTimesCount": {
        "en": "You shared the app {count} time(s) — may Allah accept it",
        "ar": "شاركت التطبيق {count} مرة — تقبّل الله منك",
        "ur": "آپ نے {count} بار ایپ شیئر کی — اللہ قبول فرمائے",
        "fa": "شما {count} بار برنامه را به اشتراک گذاشتید — خداوند قبول فرماید",
        "fr": "Vous avez partagé l'application {count} fois — qu'Allah accepte",
        "es": "Has compartido la app {count} vez/veces — que Alá lo acepte",
        "it": "Hai condiviso l'app {count} volta/volte — che Allah accetti",
        "hi": "आपने {count} बार शेयर किया — अल्लाह क़बूल फ़रमाए"
    },
    "haveFriendCode": {
        "en": "Have a friend's invite code?",
        "ar": "عندك كود دعوة من صديق؟",
        "ur": "کیا دوست کا دعوتی کوڈ ہے؟",
        "fa": "کد دعوتی از دوستان دارید؟",
        "fr": "Avez-vous le code d'un ami ?",
        "es": "¿Tienes el código de invitación de un amigo?",
        "it": "Hai il codice invito di un amico?",
        "hi": "क्या आपके पास दोस्त का इनवाइट कोड है?"
    },
    "recordedInviteFrom": {
        "en": "Recorded invite {code} — may Allah reward them",
        "ar": "تم تسجيل دعوة {code} — جزاه الله خيرًا",
        "ur": "دعوت نامہ {code} درج ہو گیا — جزاکم اللہ خیراً",
        "fa": "دعوت {code} ثبت شد — جزاه الله خیراً",
        "fr": "Invitation enregistrée de {code} — qu'Allah le récompense",
        "es": "Invitación registrada de {code} — que Alá le recompense",
        "it": "Invito registrato di {code} — che Allah lo ricompensi",
        "hi": "इनवाइट {code} दर्ज हो गया — जज़ाकल्लाहु खैरा"
    },
    "invalidInviteCode": {
        "en": "Invalid code (e.g. BSH-AB3K9)",
        "ar": "الكود غير صحيح (مثال: BSH-AB3K9)",
        "ur": "غلط کوڈ (مثال: BSH-AB3K9)",
        "fa": "کد نامعتبر است (مثال: BSH-AB3K9)",
        "fr": "Code invalide (ex: BSH-AB3K9)",
        "es": "Código no válido (ej: BSH-AB3K9)",
        "it": "Codice non valido (es: BSH-AB3K9)",
        "hi": "अमान्य कोड (उदा: BSH-AB3K9)"
    },
    "ownInviteCodeError": {
        "en": "That is your own code 🙂",
        "ar": "ده كودك أنت 🙂",
        "ur": "یہ آپ کا اپنا کوڈ ہے 🙂",
        "fa": "این کد خود شماست 🙂",
        "fr": "C'est votre propre code 🙂",
        "es": "Ese es tu propio código 🙂",
        "it": "Questo è il tuo codice personale 🙂",
        "hi": "यह आपका अपना कोड है 🙂"
    },
    "inviteShareMessage": {
        "en": "I use \"Boshra\" for Adhan, Quran and Azkar — I recommend it 🌙\nShare it as an ongoing charity — “Whoever guides someone to goodness will have a reward like one who did it.”\n\n{link}\nInvite code: {code}",
        "ar": "حمّلت تطبيق «بُشرى» للأذان والقرآن والأذكار وأنصحك به 🌙\nانشره صدقة جارية — «مَنْ دَلَّ عَلَى خَيْرٍ فَلَهُ مِثْلُ أَجْرِ فَاعِلِهِ»\n\n{link}\nكود الدعوة: {code}",
        "ur": "میں نے اذان، قرآن اور اذکار کے لیے «بشریٰ» ایپ استعمال کی اور اس کی سفارش کرتا ہوں 🌙\nاسے صدقۂ جاریہ کے طور پر شیئر کریں — «جس نے کسی نیکی کی رہنمائی کی اسے نیکی کرنے والے کے برابر اجر ملے گا»\n\n{link}\nدعوتی کوڈ: {code}",
        "fa": "من از برنامه «بُشریٰ» برای اذان، قرآن و اذکار استفاده می‌کنم و آن را پیشنهاد می‌کنم 🌙\nآن را به عنوان صدقه جاریه به اشتراک بگذارید — «هر که به کار خیری راهنمایی کند، پاداشی همانند انجام‌دهنده آن دارد»\n\n{link}\nکد دعوت: {code}",
        "fr": "J'utilise l'application « Boshra » pour l'Adhan, le Coran et les Invocations — je vous la recommande 🌙\nPartagez-la comme aumône continue (Sadaqa Jariya) — « Celui qui guide vers un bien a la même récompense que celui qui l'a accompli. »\n\n{link}\nCode d'invitation : {code}",
        "es": "Uso la aplicación «Boshra» para el Adhan, el Corán y las Súplicas — te la recomiendo 🌙\nCompártela como caridad continua — «Quien guía hacia el bien tendrá una recompensa como la de quien lo hace.»\n\n{link}\nCódigo de invitación: {code}",
        "it": "Uso l'applicazione «Boshra» per l'Adhan, il Corano e gli Azkar — ve la consiglio 🌙\nCondividetela come carità continua — «Chi guida verso il bene avrà una ricompensa pari a chi lo compie.»\n\n{link}\nCodice invito: {code}",
        "hi": "मैं अज़ान, क़ुरआन और अज़कार के लिए «बुशरा» ऐप इस्तेमाल करता हूँ — इसे ज़रूर आज़माएँ 🌙\nइसे सदक़ा-ए-जारिया समझकर शेयर करें — «जो किसी को भलाई की राह दिखाता है, उसे भलाई करने वाले जितना ही सवाब मिलता है»\n\n{link}\nइनवाइट कोड: {code}"
    },

    # ------------------ Diagnostics ------------------
    "diagTitle": {
        "en": "Will the Adhan ring?",
        "ar": "هل الأذان هيشتغل؟",
        "ur": "کیا اذان کی آواز آئے گی؟",
        "fa": "آیا اذان پخش خواهد شد؟",
        "fr": "L'Adhan va-t-il sonner ?",
        "es": "¿Sonará el Adhán?",
        "it": "L'Adhan suonerà?",
        "hi": "क्या अज़ान बजेगी?"
    },
    "diagAllGood": {
        "en": "All good — the Adhan will ring on time insha'Allah",
        "ar": "كل شيء سليم — الأذان هيشتغل في وقته إن شاء الله",
        "ur": "سب کچھ درست ہے — اذان ان شاء اللہ وقت پر بجے گی",
        "fa": "همه‌چیز مرتب است — اذان به یاری خدا سر وقت پخش می‌شود",
        "fr": "Tout est en ordre — l'Adhan sonnera à l'heure insha'Allah",
        "es": "Todo en orden — el Adhán sonará a tiempo insha'Allah",
        "it": "Tutto a posto — l'Adhan suonerà in orario insha'Allah",
        "hi": "सब ठीक है — इंशाअल्लाह अज़ान समय पर बजेगी"
    },
    "diagCanImprove": {
        "en": "The Adhan should ring, but {count} item(s) can be improved",
        "ar": "الأذان غالبًا هيشتغل، لكن في {count} نقطة تحسين",
        "ur": "اذان غالبًا بجے گی، لیکن {count} چیزوں کو بہتر کیا جا سکتا ہے",
        "fa": "اذان احتمالاً پخش می‌شود، اما {count} مورد قابل بهبود است",
        "fr": "L'Adhan devrait sonner, mais {count} point(s) peuvent être améliorés",
        "es": "El Adhán debería sonar, pero hay {count} punto(s) a mejorar",
        "it": "L'Adhan dovrebbe suonare, ma ci sono {count} punto/i da migliorare",
        "hi": "अज़ान बजनी चाहिए, लेकिन {count} चीज़ों को ठीक किया जा सकता है"
    },
    "diagProblemsFound": {
        "en": "{count} problem(s) may stop the Adhan — fix with the buttons below",
        "ar": "في {count} مشكلة ممكن تمنع الأذان — صلّحها بالأزرار تحت",
        "ur": "{count} مسائل اذان کو روک سکتے ہیں — نیچے بٹنوں سے حل کریں",
        "fa": "{count} مشکل ممکن است مانع اذان شود — با دکمه‌های زیر حل کنید",
        "fr": "{count} problème(s) peuvent bloquer l'Adhan — réparez avec les boutons ci-dessous",
        "es": "{count} problema(s) pueden impedir el Adhán — corrígelos abajo",
        "it": "{count} problema/i potrebbero impedire l'Adhan — risolvi con i pulsanti sotto",
        "hi": "{count} दिक्कतें अज़ान रोक सकती हैं — नीचे दिए गए बटनों से ठीक करें"
    },
    "diagFix": {
        "en": "Fix",
        "ar": "إصلاح",
        "ur": "درست کریں",
        "fa": "رفع مشکل",
        "fr": "Réparer",
        "es": "Corregir",
        "it": "Risolvi",
        "hi": "ठीक करें"
    },
    "diagTestAdhanNow": {
        "en": "Test Adhan now",
        "ar": "تجربة الأذان الآن",
        "ur": "ابھی اذان کا ٹیسٹ کریں",
        "fa": "آزمایش اذان هم‌اکنون",
        "fr": "Tester l'Adhan maintenant",
        "es": "Probar Adhán ahora",
        "it": "Prova l'Adhan adesso",
        "hi": "अभी अज़ान टेस्ट करें"
    },
    "diagReschedule": {
        "en": "Re-schedule",
        "ar": "إعادة الجدولة",
        "ur": "دوبارہ شیڈول کریں",
        "fa": "زمان‌بندی مجدد",
        "fr": "Re-planifier",
        "es": "Reprogramar",
        "it": "Riprogramma",
        "hi": "फिर से शेड्यूल करें"
    },
    "diagRecentEvents": {
        "en": "Recent events",
        "ar": "آخر الأحداث",
        "ur": "حالیہ واقعات",
        "fa": "رویدادهای اخیر",
        "fr": "Événements récents",
        "es": "Eventos recientes",
        "it": "Eventi recenti",
        "hi": "हालिया घटनाएं"
    },
    "diagNoEvents": {
        "en": "No events yet",
        "ar": "لا توجد أحداث بعد",
        "ur": "ابھی تک کوئی واقعہ نہیں ہے",
        "fa": "هنوز رویدادی ثبت نشده است",
        "fr": "Aucun événement pour le moment",
        "es": "Aún no hay eventos",
        "it": "Nessun evento ancora",
        "hi": "अभी तक कोई गतिविधि नहीं"
    },
    "diagCopyReport": {
        "en": "Copy report for support",
        "ar": "نسخ تقرير للدعم الفني",
        "ur": "سپورٹ کے لیے رپورٹ کاپی کریں",
        "fa": "کپی گزارش برای پشتیبانی",
        "fr": "Copier le rapport pour le support",
        "es": "Copiar informe para soporte",
        "it": "Copia report per assistenza",
        "hi": "सपोर्ट के लिए रिपोर्ट कॉपी करें"
    },
    "diagReportCopied": {
        "en": "Support report copied",
        "ar": "تم نسخ تقرير الدعم — الصقه في واتساب",
        "ur": "سپورٹ رپورٹ کاپی ہو گئی — واٹس ایپ میں پیسٹ کریں",
        "fa": "گزارش پشتیبانی کپی شد",
        "fr": "Rapport de support copié",
        "es": "Informe de soporte copiado",
        "it": "Report di supporto copiato",
        "hi": "सपोर्ट रिपोर्ट कॉपी हो गई"
    },
    "diagNotifications": {
        "en": "Notifications",
        "ar": "الإشعارات",
        "ur": "اطلاعات (نوٹیفکیشن)",
        "fa": "اعلان‌ها",
        "fr": "Notifications",
        "es": "Notificaciones",
        "it": "Notifiche",
        "hi": "नोटिफिकेशन्स"
    },
    "diagNotifEnabled": {
        "en": "Enabled",
        "ar": "مفعّلة",
        "ur": "فعال",
        "fa": "فعال",
        "fr": "Activées",
        "es": "Activadas",
        "it": "Abilitate",
        "hi": "चालू हैं"
    },
    "diagNotifBlocked": {
        "en": "Blocked — the Adhan cannot show",
        "ar": "مقفولة — الأذان مش هيظهر",
        "ur": "بند ہیں — اذان ظاہر نہیں ہو سکے گی",
        "fa": "مسدود است — اذان پخش نمی‌شود",
        "fr": "Bloquées — l'Adhan ne pourra pas s'afficher",
        "es": "Bloqueadas — el Adhán no podrá mostrarse",
        "it": "Bloccate — l'Adhan non potrà apparire",
        "hi": "बंद हैं — अज़ान स्क्रीन पर नहीं आएगी"
    },
    "diagEnable": {
        "en": "Enable",
        "ar": "تفعيل",
        "ur": "فعال کریں",
        "fa": "فعال‌سازی",
        "fr": "Activer",
        "es": "Activar",
        "it": "Attiva",
        "hi": "चालू करें"
    },
    "diagChannels": {
        "en": "Notification channels",
        "ar": "قنوات الإشعار",
        "ur": "نوٹیفکیشن چینلز",
        "fa": "کانال‌های اعلان",
        "fr": "Canaux de notification",
        "es": "Canales de notificación",
        "it": "Canali di notifica",
        "hi": "नोटिफिकेशन चैनल्स"
    },
    "diagChannelsAllEnabled": {
        "en": "All enabled",
        "ar": "كلها شغالة",
        "ur": "تمام فعال ہیں",
        "fa": "همه فعال هستند",
        "fr": "Tous activés",
        "es": "Todos activados",
        "it": "Tutti abilitati",
        "hi": "सभी चालू हैं"
    },
    "diagChannelMuted": {
        "en": "A channel is muted in system settings",
        "ar": "في قناة مكتومة من إعدادات الموبايل",
        "ur": "موبائل کی ترتیبات میں ایک چینل خاموش ہے",
        "fa": "یکی از کانال‌ها در تنظیمات گوشی بی‌صدا شده است",
        "fr": "Un canal est mis en sourdine dans les paramètres du système",
        "es": "Un canal está silenciado en los ajustes del sistema",
        "it": "Un canale è silenziato nelle impostazioni di sistema",
        "hi": "फ़ोन सेटिंग्स में एक चैनल म्यूट है"
    },
    "diagOpenSettings": {
        "en": "Open settings",
        "ar": "فتح الإعدادات",
        "ur": "سیٹنگز کھولیں",
        "fa": "باز کردن تنظیمات",
        "fr": "Ouvrir les paramètres",
        "es": "Abrir ajustes",
        "it": "Apri impostazioni",
        "hi": "सेटिंग्स खोलें"
    },
    "diagExactAlarms": {
        "en": "Exact alarms",
        "ar": "المنبّهات الدقيقة",
        "ur": "درست الارم",
        "fa": "هشدارهای دقیق",
        "fr": "Alarmes précises",
        "es": "Alarmas exactas",
        "it": "Allarmi precisi",
        "hi": "सटीक अलार्म"
    },
    "diagExactAlarmsAllowed": {
        "en": "Allowed — Adhan fires on the second",
        "ar": "مسموحة — الأذان في الثانية المضبوطة",
        "ur": "اجازت ہے — اذان بالکل وقت پر بجے گی",
        "fa": "مجاز است — اذان دقیقاً در ثانیه مقرر پخش می‌شود",
        "fr": "Autorisé — l'Adhan sonne à la seconde exacte",
        "es": "Permitido — el Adhán suena al segundo exacto",
        "it": "Consentito — l'Adhan scatta al secondo esatto",
        "hi": "अनुमति है — अज़ान बिल्कुल सही सेकंड पर बजेगी"
    },
    "diagExactAlarmsNotAllowed": {
        "en": "Not allowed — the Adhan may be late",
        "ar": "غير مسموحة — الأذان ممكن يتأخر",
        "ur": "اجازت نہیں — اذان تاخیر سے ہو سکتی ہے",
        "fa": "غیرمجاز است — ممکن است اذان با تأخیر پخش شود",
        "fr": "Non autorisé — l'Adhan risque d'être en retard",
        "es": "No permitido — el Adhán podría retrasarse",
        "it": "Non consentito — l'Adhan potrebbe ritardare",
        "hi": "अनुमति नहीं है — अज़ान देर से हो सकती है"
    },
    "diagAllow": {
        "en": "Allow",
        "ar": "السماح",
        "ur": "اجازت دیں",
        "fa": "اجازه‌دادن",
        "fr": "Autoriser",
        "es": "Permitir",
        "it": "Consenti",
        "hi": "अनुमति दें"
    },
    "diagBattery": {
        "en": "Battery optimisation",
        "ar": "تحسين البطارية",
        "ur": "بیٹری آپٹیمائزیشن",
        "fa": "بهینه‌سازی باتری",
        "fr": "Optimisation de batterie",
        "es": "Optimización de batería",
        "it": "Ottimizzazione batteria",
        "hi": "बैटरी ऑप्टिमाइज़ेशन"
    },
    "diagBatteryExempt": {
        "en": "App is exempt",
        "ar": "التطبيق مستثنى",
        "ur": "ایپ مستثنیٰ ہے",
        "fa": "برنامه مستثنی است",
        "fr": "Application exemptée",
        "es": "Aplicación excluida",
        "it": "Applicazione esentata",
        "hi": "ऐप छूट प्राप्त है"
    },
    "diagBatteryMayKill": {
        "en": "The system may stop the app in background",
        "ar": "النظام ممكن يوقف التطبيق في الخلفية",
        "ur": "سسٹم بیک گراؤنڈ میں ایپ بند کر سکتا ہے",
        "fa": "سیستم ممکن است برنامه را در پس‌زمینه متوقف کند",
        "fr": "Le système risque d'arrêter l'app en arrière-plan",
        "es": "El sistema podría detener la aplicación en segundo plano",
        "it": "Il sistema potrebbe arrestare l'app in background",
        "hi": "सिस्टम बैकग्राउंड में ऐप को बंद कर सकता है"
    },
    "diagExempt": {
        "en": "Exempt",
        "ar": "استثناء",
        "ur": "استثناء دیں",
        "fa": "مستثنی‌کردن",
        "fr": "Exempter",
        "es": "Excluir",
        "it": "Esenta",
        "hi": "छूट दें"
    },
    "diagPrayerMode": {
        "en": "Prayer mode",
        "ar": "وضع الصلاة",
        "ur": "نماز موڈ",
        "fa": "حالت نماز",
        "fr": "Mode prière",
        "es": "Modo oración",
        "it": "Modalità preghiera",
        "hi": "नमाज़ मोड"
    },
    "diagPrayerModeFullSilence": {
        "en": "Full silence ready (DND access granted)",
        "ar": "الكتم الكامل جاهز (عدم الإزعاج مسموح)",
        "ur": "مکمل خاموشی تیار ہے (Do Not Disturb کی اجازت ہے)",
        "fa": "سکوت کامل آماده است (مجوز عدم مزاحمت دارد)",
        "fr": "Silence total prêt (accès Ne pas déranger accordé)",
        "es": "Silencio total listo (permiso No Molestar concedido)",
        "it": "Silenzio totale pronto (accesso Non Disturbare consentito)",
        "hi": "पूरा साइलेंट तैयार है (DND अनुमति मिली हुई है)"
    },
    "diagPrayerModeVibrateOnly": {
        "en": "Without \"Do Not Disturb access\" we can only switch to vibrate",
        "ar": "بدون صلاحية «عدم الإزعاج» هنكتفي بوضع الاهتزاز",
        "ur": "بغیر اجازت ہم صرف وائبریشن موڈ پر جا سکتے ہیں",
        "fa": "بدون مجوز «عدم مزاحمت» فقط حالت لرزش فعال می‌شود",
        "fr": "Sans accès « Ne pas déranger », nous ne pouvons passer qu'en vibreur",
        "es": "Sin acceso a «No molestar», solo podemos activar la vibración",
        "it": "Senza accesso a «Non disturbare» possiamo solo vibrare",
        "hi": "«DND» अनुमति के बिना केवल वाइब्रेशन ही हो पाएगा"
    },
    "diagGrantPermission": {
        "en": "Grant access",
        "ar": "منح الصلاحية",
        "ur": "اجازت دیں",
        "fa": "اعطای مجوز",
        "fr": "Accorder l'accès",
        "es": "Conceder permiso",
        "it": "Concedi permesso",
        "hi": "अनुमति दें"
    },
    "diagAutostart": {
        "en": "Auto-start",
        "ar": "التشغيل التلقائي",
        "ur": "خودکار آغاز (Auto-start)",
        "fa": "شروع خودکار",
        "fr": "Démarrage automatique",
        "es": "Inicio automático",
        "it": "Avvio automatico",
        "hi": "ऑटो-स्टार्ट"
    },
    "diagAutostartConfigured": {
        "en": "Configured ({brand})",
        "ar": "تم ضبطه ({brand})",
        "ur": "ترتیب دیا گیا ({brand})",
        "fa": "تنظیم شده است ({brand})",
        "fr": "Configuré ({brand})",
        "es": "Configurado ({brand})",
        "it": "Configurato ({brand})",
        "hi": "सेट हो गया ({brand})"
    },
    "diagAutostartNeeds": {
        "en": "{brand} kills background apps — enable auto-start",
        "ar": "جهاز {brand} بيقفل التطبيقات — فعّل التشغيل التلقائي",
        "ur": "{brand} ڈیوائس ایپس کو بند کر دیتی ہے — آٹو سٹارٹ فعال کریں",
        "fa": "دستگاه {brand} برنامه‌ها را می‌بندد — شروع خودکار را روشن کنید",
        "fr": "L'appareil {brand} ferme les applications — activez le démarrage automatique",
        "es": "Los dispositivos {brand} cierran apps en segundo plano — activa el inicio automático",
        "it": "I dispositivi {brand} chiudono le app — attiva l'avvio automatico",
        "hi": "{brand} डिवाइस बैकग्राउंड ऐप्स बंद करता है — ऑटो-स्टार्ट चालू करें"
    },
    "diagOpen": {
        "en": "Open",
        "ar": "فتح",
        "ur": "کھولیں",
        "fa": "باز کردن",
        "fr": "Ouvrir",
        "es": "Abrir",
        "it": "Apri",
        "hi": "खोलें"
    },
    "diagLocation": {
        "en": "Location",
        "ar": "الموقع",
        "ur": "مقام",
        "fa": "موقعیت مکانی",
        "fr": "Localisation",
        "es": "Ubicación",
        "it": "Posizione",
        "hi": "स्थान (लोकेशन)"
    },
    "diagLocationManual": {
        "en": "Manual city: {city}",
        "ar": "مدينة مختارة يدويًا: {city}",
        "ur": "دستی منتخب شدہ شہر: {city}",
        "fa": "شهر انتخابی دستی: {city}",
        "fr": "Ville manuelle : {city}",
        "es": "Ciudad manual: {city}",
        "it": "Città manuale: {city}",
        "hi": "मैन्युअल चुना गया शहर: {city}"
    },
    "diagLocationApprox": {
        "en": "Approximate",
        "ar": "تقريبي",
        "ur": "تخمینی",
        "fa": "تقریبی",
        "fr": "Approximatif",
        "es": "Aproximada",
        "it": "Approssimativa",
        "hi": "अनुमानित"
    },
    "diagLocationUnknown": {
        "en": "Unknown — using a default city",
        "ar": "مش متحدد — بنستخدم مدينة افتراضية",
        "ur": "نامعلوم — پہلے سے طے شدہ شہر استعمال ہو رہا ہے",
        "fa": "نامشخص — استفاده از شهر پیش‌فرض",
        "fr": "Inconnu — utilisation d'une ville par défaut",
        "es": "Desconocida — usando ciudad predeterminada",
        "it": "Sconosciuta — uso città predefinita",
        "hi": "अज्ञात — डिफ़ॉल्ट शहर इस्तेमाल हो रहा है"
    },
    "diagLocationGpsOff": {
        "en": "Location service (GPS) is off",
        "ar": "خدمة الموقع (GPS) مقفولة",
        "ur": "مقام کی سروس (GPS) بند ہے",
        "fa": "سرویس موقعیت مکانی (GPS) خاموش است",
        "fr": "Le service de localisation (GPS) est désactivé",
        "es": "El servicio de ubicación (GPS) está apagado",
        "it": "Il servizio di localizzazione (GPS) è disattivato",
        "hi": "लोकेशन सेवा (GPS) बंद है"
    },
    "diagLocationDenied": {
        "en": "Location permission denied",
        "ar": "إذن الموقع مرفوض",
        "ur": "مقام کی اجازت مسترد ہے",
        "fa": "مجوز موقعیت مکانی رد شد",
        "fr": "Autorisation de localisation refusée",
        "es": "Permiso de ubicación denegado",
        "it": "Autorizzazione di posizione negata",
        "hi": "लोकेशन अनुमति अस्वीकृत है"
    },
    "diagLocationPermanentlyDenied": {
        "en": "Permission permanently denied — open settings",
        "ar": "إذن الموقع مرفوض نهائيًا — افتحه من الإعدادات",
        "ur": "اجازت مستقل طور پر مسترد — ترتیبات کھولیں",
        "fa": "مجوز به طور دائم رد شده است — تنظیمات را باز کنید",
        "fr": "Autorisation refusée définitivement — ouvrez les paramètres",
        "es": "Permiso denegado permanentemente — abre ajustes",
        "it": "Permesso negato in modo permanente — apri impostazioni",
        "hi": "अनुमति स्थायी रूप से अस्वीकृत — सेटिंग्स खोलें"
    },
    "diagLocationNoFix": {
        "en": "Device could not get a fix (weak signal / Location accuracy off)",
        "ar": "الجهاز ما قدرش يحدد موقعك (إشارة ضعيفة / دقة الموقع مقفولة)",
        "ur": "ڈیوائس مقام کا تعین نہیں کر سکی (کمزور سگنل)",
        "fa": "دستگاه نتوانست موقعیت را تعیین کند (سیگنال ضعیف)",
        "fr": "Impossible de déterminer la position (signal faible)",
        "es": "No se pudo determinar la ubicación (señal débil)",
        "it": "Impossibile rilevare la posizione (segnale debole)",
        "hi": "डिवाइस स्थान तय नहीं कर सका (कमज़ोर सिग्नल)"
    },
    "diagLocationMock": {
        "en": "A mock location is active on the device — ignored",
        "ar": "في موقع وهمي مفعّل على الجهاز — بنتجاهله",
        "ur": "فرضی لوکیشن فعال ہے — نظر انداز کیا گیا",
        "fa": "موقعیت مکانی جعلی فعال است — نادیده گرفته شد",
        "fr": "Une fausse localisation est active — ignorée",
        "es": "Ubicación simulada activa — ignorada",
        "it": "Posizione fittizia attiva — ignorata",
        "hi": "नकली लोकेशन चालू है — अनदेखा किया गया"
    },
    "diagLocationTzMismatch": {
        "en": "Fix contradicts the device time zone (mock location?)",
        "ar": "الموقع متعارض مع المنطقة الزمنية للجهاز (موقع وهمي؟)",
        "ur": "مقام ڈیوائس کے ٹائم زون سے متصادم ہے",
        "fa": "موقعیت با منطقه زمانی دستگاه ناسازگار است",
        "fr": "La position contredit le fuseau horaire de l'appareil",
        "es": "La posición contradice la zona horaria del dispositivo",
        "it": "La posizione contraddice il fuso orario del dispositivo",
        "hi": "लोकेशन टाइमज़ोन से मेल नहीं खाती"
    },
    "diagFixLocation": {
        "en": "Fix location",
        "ar": "تحديد دقيق",
        "ur": "مقام درست کریں",
        "fa": "تنظیم دقیق موقعیت",
        "fr": "Corriger la position",
        "es": "Corregir ubicación",
        "it": "Correggi posizione",
        "hi": "लोकेशन सही करें"
    },
    "diagSetLocation": {
        "en": "Set",
        "ar": "تحديد",
        "ur": "متعین کریں",
        "fa": "تعیین",
        "fr": "Définir",
        "es": "Establecer",
        "it": "Imposta",
        "hi": "तय करें"
    },
    "diagLastScheduling": {
        "en": "Last scheduling",
        "ar": "آخر جدولة",
        "ur": "آخری شیڈولنگ",
        "fa": "آخرین زمان‌بندی",
        "fr": "Dernière planification",
        "es": "Última programación",
        "it": "Ultima pianificazione",
        "hi": "पिछला शेड्यूल"
    },
    "diagNeverScheduled": {
        "en": "Never scheduled yet",
        "ar": "لسه ما اتجدولش",
        "ur": "ابھی تک شیڈول نہیں ہوا",
        "fa": "هنوز زمان‌بندی نشده است",
        "fr": "Pas encore planifié",
        "es": "Aún no se ha programado",
        "it": "Non ancora programmato",
        "hi": "अभी तक शेड्यूल नहीं हुआ"
    },
    "diagScheduleNow": {
        "en": "Schedule now",
        "ar": "جدولة الآن",
        "ur": "ابھی شیڈول کریں",
        "fa": "زمان‌بندی هم‌اکنون",
        "fr": "Planifier maintenant",
        "es": "Programar ahora",
        "it": "Pianifica adesso",
        "hi": "अभी शेड्यूल करें"
    },
    "diagScheduleAlertsCount": {
        "en": "{count} alerts",
        "ar": "{count} تنبيه",
        "ur": "{count} تنبیہات",
        "fa": "{count} هشدار",
        "fr": "{count} alertes",
        "es": "{count} alertas",
        "it": "{count} avvisi",
        "hi": "{count} अलर्ट्स"
    },
    "diagScheduleIncomplete": {
        "en": "incomplete (offline calc)",
        "ar": "ناقصة (اتحسب أوفلاين)",
        "ur": "نامکمل (آف لائن حساب)",
        "fa": "ناقص (محاسبه آفلاین)",
        "fr": "incomplet (calcul hors ligne)",
        "es": "incompleto (cálculo sin conexión)",
        "it": "incompleto (calcolo offline)",
        "hi": "अधूरा (ऑफ़लाइन गणना)"
    },
    "diagScheduleError": {
        "en": "error",
        "ar": "حصل خطأ",
        "ur": "خرابی پیش آگئی",
        "fa": "خطا رخ داد",
        "fr": "erreur",
        "es": "error",
        "it": "errore",
        "hi": "त्रुटि हुई"
    },
    "diagNextAdhan": {
        "en": "Next Adhan",
        "ar": "الأذان القادم",
        "ur": "اگلی اذان",
        "fa": "اذان بعدی",
        "fr": "Prochain Adhan",
        "es": "Próximo Adhán",
        "it": "Prossimo Adhan",
        "hi": "अगली अज़ान"
    },
    "diagAllPrayersSilent": {
        "en": "All prayers are set to short/silent (no full Adhan)",
        "ar": "كل الصلوات مضبوطة على إشعار قصير/صامت (مش أذان كامل)",
        "ur": "تمام نمازیں مختصر/خاموش پر سیٹ ہیں (مکمل اذان نہیں)",
        "fa": "همه نمازها روی اعلان کوتاه/بی‌صدا تنظیم شده‌اند",
        "fr": "Toutes les prières sont sur silencieux ou notification courte",
        "es": "Todas las oraciones están en silencio o tono corto",
        "it": "Tutte le preghiere sono impostate su silenzioso o notifica breve",
        "hi": "सभी नमाज़ें शॉर्ट/साइलेंट पर सेट हैं (पूरी अज़ान नहीं)"
    },
    "diagArmedAdhansCount": {
        "en": "{count} Adhans armed in the system",
        "ar": "{count} أذان مجدول في النظام",
        "ur": "سسٹم میں {count} اذانیں شیڈول ہیں",
        "fa": "{count} اذان در سیستم برنامه‌ریزی شده است",
        "fr": "{count} Adhans programmés dans le système",
        "es": "{count} Adhán programados en el sistema",
        "it": "{count} Adhan programmati nel sistema",
        "hi": "सिस्टम में {count} अज़ानें शेड्यूल हैं"
    },
    "diagNoAdhanArmed": {
        "en": "No Adhan is armed in the alarm system! Tap schedule",
        "ar": "مفيش أذان مجدول في المنبّه! اضغط جدولة",
        "ur": "الارم میں کوئی اذان شیڈول نہیں! شیڈول پر ٹیپ کریں",
        "fa": "هیچ اذانی در سیستم هشدار تنظیم نشده! زمان‌بندی را بزنید",
        "fr": "Aucun Adhan n'est armé dans les alarmes ! Appuyez sur planifier",
        "es": "¡No hay ningún Adhán programado! Pulsa programar",
        "it": "Nessun Adhan programmato negli allarmi! Tocca pianifica",
        "hi": "अलार्म में कोई अज़ान शेड्यूल नहीं है! शेड्यूल दबाएँ"
    },
    "diagOfflineMode": {
        "en": "Offline mode",
        "ar": "الوضع الأوفلاين",
        "ur": "آف لائن موڈ",
        "fa": "حالت آفلاین",
        "fr": "Mode hors ligne",
        "es": "Modo sin conexión",
        "it": "Modalità offline",
        "hi": "ऑफ़लाइन मोड"
    },
    "diagOfflineMonthsCached": {
        "en": "{count} months cached — works without internet",
        "ar": "{count} أشهر محفوظة — يشتغل بدون إنترنت",
        "ur": "{count} ماہ محفوظ ہیں — انٹرنیٹ کے بغیر کام کرے گا",
        "fa": "{count} ماه ذخیره شده — بدون اینترنت کار می‌کند",
        "fr": "{count} mois en cache — fonctionne sans internet",
        "es": "{count} meses en caché — funciona sin internet",
        "it": "{count} mesi in cache — funziona senza internet",
        "hi": "{count} महीने सेव हैं — बिना इंटरनेट काम करेगा"
    },
    "diagOfflineMonthsOnly": {
        "en": "Only {count} month cached (auto-completes online)",
        "ar": "محفوظ {count} شهر فقط (هيتكمّل تلقائيًا مع الإنترنت)",
        "ur": "صرف {count} ماہ محفوظ ہے (آن لائن ہونے پر مکمل ہوگا)",
        "fa": "فقط {count} ماه ذخیره شده (آنلاین تکمیل می‌شود)",
        "fr": "Seulement {count} mois en cache (se complètera en ligne)",
        "es": "Solo {count} mes en caché (se completará con conexión)",
        "it": "Solo {count} mese in cache (si completerà online)",
        "hi": "केवल {count} महीना सेव है (इंटरनेट आने पर पूरा होगा)"
    },
    "diagInternet": {
        "en": "Internet",
        "ar": "الإنترنت",
        "ur": "انٹرنیٹ",
        "fa": "اینترنت",
        "fr": "Internet",
        "es": "Internet",
        "it": "Internet",
        "hi": "इंटरनेट"
    },
    "diagInternetConnected": {
        "en": "Reaching the prayer-times server",
        "ar": "متصل بخادم المواعيد",
        "ur": "نماز کے اوقات کے سرور سے منسلک ہے",
        "fa": "متصل به سرور اوقات شرعی",
        "fr": "Connecté au serveur des horaires",
        "es": "Conectado al servidor de horarios",
        "it": "Connesso al server degli orari",
        "hi": "नमाज़ समय सर्वर से जुड़ा है"
    },
    "diagInternetUnavailable": {
        "en": "Unavailable now — cached times are enough",
        "ar": "غير متاح الآن — مش مشكلة، المواعيد المحفوظة تكفي",
        "ur": "ابھی دستیاب نہیں — محفوظ شدہ اوقات کافی ہیں",
        "fa": "هم‌اکنون در دسترس نیست — اوقات ذخیره شده کافی است",
        "fr": "Indisponible actuellement — les horaires en cache suffisent",
        "es": "No disponible ahora — los horarios guardados bastan",
        "it": "Non disponibile ora — gli orari salvati sono sufficienti",
        "hi": "अभी उपलब्ध नहीं — सेव किए गए समय काफ़ी हैं"
    },
    "diagTestAdhanTitle": {
        "en": "Adhan test",
        "ar": "تجربة الأذان",
        "ur": "اذان کا ٹیسٹ",
        "fa": "تست اذان",
        "fr": "Test de l'Adhan",
        "es": "Prueba del Adhán",
        "it": "Test dell'Adhan",
        "hi": "अज़ान टेस्ट"
    },
    "diagTestAdhanBody": {
        "en": "If you hear this, everything works",
        "ar": "لو سمعت الأذان يبقى كل حاجة تمام",
        "ur": "اگر آپ نے آواز سنی تو سب درست ہے",
        "fa": "اگر صدا را می‌شنوید، همه‌چیز درست کار می‌کند",
        "fr": "Si vous entendez cela, tout fonctionne",
        "es": "Si escuchas esto, todo funciona correctamente",
        "it": "Se senti questo, tutto funziona",
        "hi": "अगर आपको आवाज़ आ रही है तो सब ठीक है"
    },
    "diagStop": {
        "en": "Stop",
        "ar": "إيقاف",
        "ur": "روکیں",
        "fa": "توقف",
        "fr": "Arrêter",
        "es": "Detener",
        "it": "Stop",
        "hi": "रोकें"
    },
    "diagAgoJustNow": {
        "en": "just now",
        "ar": "الآن",
        "ur": "ابھی",
        "fa": "هم‌اکنون",
        "fr": "à l'instant",
        "es": "ahora mismo",
        "it": "adesso",
        "hi": "अभी"
    },
    "diagAgoMinutes": {
        "en": "{m} min ago",
        "ar": "من {m} دقيقة",
        "ur": "{m} منٹ پہلے",
        "fa": "{m} دقیقه پیش",
        "fr": "il y a {m} min",
        "es": "hace {m} min",
        "it": "{m} min fa",
        "hi": "{m} मिनट पहले"
    },
    "diagAgoHours": {
        "en": "{h} h ago",
        "ar": "من {h} ساعة",
        "ur": "{h} گھنٹے پہلے",
        "fa": "{h} ساعت پیش",
        "fr": "il y a {h} h",
        "es": "hace {h} h",
        "it": "{h} ore fa",
        "hi": "{h} घंटे पहले"
    },
    "diagAgoDays": {
        "en": "{d} d ago",
        "ar": "من {d} يوم",
        "ur": "{d} دن پہلے",
        "fa": "{d} روز پیش",
        "fr": "il y a {d} j",
        "es": "hace {d} d",
        "it": "{d} giorni fa",
        "hi": "{d} दिन पहले"
    },

    # ------------------ Zakat ------------------
    "zakatCalculatorTitle": {
        "en": "Zakat Calculator",
        "ar": "حاسبة الزكاة",
        "ur": "زکوٰۃ کیلکولیٹر",
        "fa": "محاسبه‌گر زکات",
        "fr": "Calculateur de Zakat",
        "es": "Calculadora de Zakat",
        "it": "Calcolatore della Zakat",
        "hi": "ज़कात कैलकुलेटर"
    },
    "zakatCurrency": {
        "en": "Currency",
        "ar": "العملة",
        "ur": "کرنسی",
        "fa": "ارز",
        "fr": "Devise",
        "es": "Moneda",
        "it": "Valuta",
        "hi": "मुद्रा (करेंसी)"
    },
    "zakatTodayPricesGram": {
        "en": "Today's prices (per gram)",
        "ar": "أسعار اليوم (للجرام)",
        "ur": "آج کی قیمتیں (فی گرام)",
        "fa": "قیمت‌های امروز (هر گرم)",
        "fr": "Prix du jour (au gramme)",
        "es": "Precios de hoy (por gramo)",
        "it": "Prezzi di oggi (al grammo)",
        "hi": "आज के भाव (प्रति ग्राम)"
    },
    "zakatRefresh": {
        "en": "Refresh",
        "ar": "تحديث",
        "ur": "تازہ کریں",
        "fa": "بروزرسانی",
        "fr": "Actualiser",
        "es": "Actualizar",
        "it": "Aggiorna",
        "hi": "रिफ्रेश"
    },
    "zakatEditManually": {
        "en": "Edit manually",
        "ar": "تعديل يدوي",
        "ur": "دستی ترمیم",
        "fa": "ویرایش دستی",
        "fr": "Modifier manuellement",
        "es": "Editar manualmente",
        "it": "Modifica manualmente",
        "hi": "खुद बदलें"
    },
    "zakatCouldNotLoadPrices": {
        "en": "Could not load prices (offline). Tap ✏️ to enter the per-gram price.",
        "ar": "تعذّر جلب الأسعار (لا إنترنت). اضغط ✏️ لإدخال سعر الجرام يدويًا.",
        "ur": "قیمتیں لوڈ نہیں ہو سکیں (انٹرنیٹ نہیں ہے)۔ فی گرام قیمت درج کرنے کے لیے ✏️ دبائیں۔",
        "fa": "بارگذاری قیمت‌ها ممکن نشد (آفلاین). برای وارد کردن دستی قیمت روی ✏️ بزنید.",
        "fr": "Impossible de charger les cours (hors ligne). Appuyez sur ✏️ pour saisir le prix au gramme.",
        "es": "No se pudieron cargar los precios (sin conexión). Pulsa ✏️ para introducirlos manualmente.",
        "it": "Impossibile caricare i prezzi (offline). Tocca ✏️ per inserire il prezzo al grammo.",
        "hi": "भाव लोड नहीं हो सके (ऑफ़लाइन)। प्रति ग्राम भाव डालने के लिए ✏️ पर टैप करें।"
    },
    "zakatGold24": {
        "en": "Gold 24k",
        "ar": "ذهب عيار 24",
        "ur": "24 قیراط سونا",
        "fa": "طلای ۲۴ عیار",
        "fr": "Or 24 carats",
        "es": "Oro de 24 quilates",
        "it": "Oro 24 carati",
        "hi": "24 कैरेट सोना"
    },
    "zakatGold21": {
        "en": "Gold 21k",
        "ar": "ذهب عيار 21",
        "ur": "21 قیراط سونا",
        "fa": "طلای ۲۱ عیار",
        "fr": "Or 21 carats",
        "es": "Oro de 21 quilates",
        "it": "Oro 21 carati",
        "hi": "21 कैरेट सोना"
    },
    "zakatGold18": {
        "en": "Gold 18k",
        "ar": "ذهب عيار 18",
        "ur": "18 قیراط سونا",
        "fa": "طلای ۱۸ عیار",
        "fr": "Or 18 carats",
        "es": "Oro de 18 quilates",
        "it": "Oro 18 carati",
        "hi": "18 कैरेट सोना"
    },
    "zakatSilver": {
        "en": "Silver",
        "ar": "فضة",
        "ur": "چاندی",
        "fa": "نقره",
        "fr": "Argent",
        "es": "Plata",
        "it": "Argento",
        "hi": "चांदी"
    },
    "zakatGram": {
        "en": "g",
        "ar": "جرام",
        "ur": "گرام",
        "fa": "گرم",
        "fr": "g",
        "es": "g",
        "it": "g",
        "hi": "ग्राम"
    },
    "zakatUsingManualPrices": {
        "en": "✏️ Using your manual prices",
        "ar": "✏️ تستخدم أسعارك اليدوية",
        "ur": "✏️ آپ کی دستی درج کردہ قیمتیں استعمال ہو رہی ہیں",
        "fa": "✏️ استفاده از قیمت‌های دستی شما",
        "fr": "✏️ Utilisation de vos prix manuels",
        "es": "✏️ Usando tus precios manuales",
        "it": "✏️ Utilizzo dei tuoi prezzi manuali",
        "hi": "✏️ आपके दर्ज किए भाव इस्तेमाल हो रहे हैं"
    },
    "zakatWorldPriceStamp": {
        "en": "World price × exchange rate — updated {date}",
        "ar": "سعر عالمي × سعر الصرف — محدّث {date}",
        "ur": "عالمی قیمت × شرح تبادلہ — اپ ڈیٹ: {date}",
        "fa": "قیمت جهانی × نرخ ارز — بروزرسانی: {date}",
        "fr": "Cours mondial × taux de change — mis à jour {date}",
        "es": "Precio global × tipo de cambio — actualizado {date}",
        "it": "Prezzo globale × tasso di cambio — aggiornato {date}",
        "hi": "वैश्विक भाव × विनिमय दर — अपडेट: {date}"
    },
    "zakatPriceOld": {
        "en": " (old)",
        "ar": " (قديم)",
        "ur": " (پرانا)",
        "fa": " (قدیمی)",
        "fr": " (ancien)",
        "es": " (antiguo)",
        "it": " (vecchio)",
        "hi": " (पुराना)"
    },
    "zakatNisab": {
        "en": "Nisab",
        "ar": "النصاب",
        "ur": "نصاب",
        "fa": "نصاب",
        "fr": "Nissab",
        "es": "Nisab",
        "it": "Nisab",
        "hi": "निसाब"
    },
    "zakatGoldNisab": {
        "en": "Gold (85 g)",
        "ar": "ذهب (85 جم)",
        "ur": "سونا (85 گرام)",
        "fa": "طلا (۸۵ گرم)",
        "fr": "Or (85 g)",
        "es": "Oro (85 g)",
        "it": "Oro (85 g)",
        "hi": "सोना (85 ग्राम)"
    },
    "zakatSilverNisab": {
        "en": "Silver (595 g)",
        "ar": "فضة (595 جم)",
        "ur": "چاندی (595 گرام)",
        "fa": "نقره (۵۹۵ گرم)",
        "fr": "Argent (595 g)",
        "es": "Plata (595 g)",
        "it": "Argento (595 g)",
        "hi": "चांदी (595 ग्राम)"
    },
    "zakatNisabExplanation": {
        "en": "Use the nisab your trusted scholarly authority uses. The silver nisab is lower in value, so it covers more people.",
        "ar": "اعتمد النصاب الذي تفتي به الجهة التي تثق بها (دار الإفتاء في بلدك). نصاب الفضة أقل قيمة فيشمل عددًا أكبر من الناس.",
        "ur": "اپنے معتبر دارالافتاء کے فتوے کے مطابق نصاب منتخب کریں۔ چاندی کا نصاب کم قیمت ہے اس لیے زیادہ مستحقین کو فائدہ پہنچاتا ہے۔",
        "fa": "نصابی را که مرجع دینی مورد اعتمادتان فتوا داده برگزینید. نصاب نقره کمتر است و افراد بیشتری را شامل می‌شود.",
        "fr": "Utilisez le nissab préconisé par votre autorité religieuse de confiance. Le nissab d'argent étant plus bas, il concerne davantage de donateurs.",
        "es": "Usa el nisab recomendado por las autoridades académicas de tu confianza. El nisab de plata es menor, beneficiando a más necesitados.",
        "it": "Usa il nisab indicato dalla tua autorità religiosa di fiducia. Il nisab d'argento ha un valore inferiore e copre più persone.",
        "hi": "अपने विश्वस्त उलेमा या दारुल इफ़्ता के अनुसार निसाब चुनें। चांदी का निसाब कम मूल्य का होता है, जिससे अधिक लोग शामिल होते हैं।"
    },
    "zakatYourWealth": {
        "en": "Your wealth",
        "ar": "أموالك",
        "ur": "آپ کا مال و دولت",
        "fa": "اموال شما",
        "fr": "Vos biens",
        "es": "Tus bienes",
        "it": "I tuoi beni",
        "hi": "आपकी संपत्ति"
    },
    "zakatCashSavings": {
        "en": "Cash, savings & bank accounts",
        "ar": "النقد والمدخرات والحسابات البنكية",
        "ur": "نقدی، بچت اور بینک اکاؤنٹس",
        "fa": "پول نقد، پس‌انداز و حساب‌های بانکی",
        "fr": "Espèces, épargne et comptes bancaires",
        "es": "Efectivo, ahorros y cuentas bancarias",
        "it": "Contanti, risparmi e conti bancari",
        "hi": "नकद, बचत और बैंक खाते"
    },
    "zakatSharesInvestments": {
        "en": "Shares & investments",
        "ar": "أسهم واستثمارات وصناديق",
        "ur": "حصص (شیئرز)، سرمایہ کاری اور فنڈز",
        "fa": "سهام، سرمایه‌گذاری‌ها و صندوق‌ها",
        "fr": "Actions, investissements et fonds",
        "es": "Acciones, inversiones y fondos",
        "it": "Azioni, investimenti e fondi",
        "hi": "शेयर और निवेश"
    },
    "zakatTradeGoods": {
        "en": "Trade goods (market value)",
        "ar": "بضاعة تجارة (بسعر السوق)",
        "ur": "مالِ تجارت (مارکیٹ ویلیو کے مطابق)",
        "fa": "کالای تجاری (به ارزش بازار)",
        "fr": "Marchandises commerciales (valeur marchande)",
        "es": "Mercancías de comercio (valor de mercado)",
        "it": "Merci commerciali (valore di mercato)",
        "hi": "व्यापार का माल (बाज़ार भाव)"
    },
    "zakatMoneyOwedToYou": {
        "en": "Money owed to you (reliable)",
        "ar": "ديون لك مضمونة السداد",
        "ur": "وہ قرض جو آپ کو واپس ملنے کی امید ہے",
        "fa": "طلب‌های شما که بازپرداخت آن‌ها قطعی است",
        "fr": "Argent qu'on vous doit (recouvrable)",
        "es": "Dinero que te deben (de cobro seguro)",
        "it": "Crediti da riscuotere (sicuri)",
        "hi": "दूसरों पर आपका सुरक्षित क़र्ज़"
    },
    "zakatDebtsDue": {
        "en": "Debts you owe now (deducted)",
        "ar": "ديون عليك مستحقة الآن (تُخصم)",
        "ur": "وہ قرض جو آپ پر ابھی واجب الادا ہیں (منہا کیے جائیں گے)",
        "fa": "بدهی‌های فوری شما (کسر می‌شود)",
        "fr": "Dettes immédiates que vous devez (déduites)",
        "es": "Deudas inmediatas que debes (a deducir)",
        "it": "Debiti a breve termine da pagare (dedotti)",
        "hi": "तुरंत चुकाने वाले क़र्ज़ (घटाए जाएंगे)"
    },
    "zakatJewelleryNote": {
        "en": "Scholars differ on zakat for worn jewellery; it is counted here — leave the gold fields empty if you follow the other view.",
        "ar": "اختلف العلماء في زكاة الحلي المستعمل للزينة؛ الحاسبة تحسبه، فإن كان رأي من تقلّده عدم الزكاة فيه فاترك خانات الذهب فارغة.",
        "ur": "استعمالی زیورات کی زکوٰۃ میں علماء کا اختلاف ہے؛ اگر آپ کے مسلک میں زکوٰۃ نہیں ہے تو سونے کے خانے خالی چھوڑ دیں۔",
        "fa": "علما در مورد زکات زیورآلات مورد استفاده اختلاف دارند؛ در صورت عدم وجوب در مذهب شما، فیلدهای طلا را خالی بگذارید.",
        "fr": "Les savants divergent sur la Zakat des bijoux portés ; si vous suivez l'avis dispensateur, laissez les champs vides.",
        "es": "Los eruditos difieren sobre las joyas de uso personal; déjalas vacías si sigues la opinión de exención.",
        "it": "Gli studiosi divergono sulla Zakat per i gioielli personali; lascia vuoti i campi se segui l'opinione di esenzione.",
        "hi": "इस्तेमाल के ज़ेवरात पर ज़कात में मतभेद है; अगर आपकी मान्यता में ज़कात नहीं है तो सोने का कॉलम खाली छोड़ दें।"
    },
    "zakatTotalZakatableWealth": {
        "en": "Total zakatable wealth",
        "ar": "إجمالي المال الخاضع للزكاة",
        "ur": "کل قابلِ زکوٰۃ مال",
        "fa": "کل دارایی مشمول زکات",
        "fr": "Total des biens assujettis à la Zakat",
        "es": "Total de bienes sujetos a Zakat",
        "it": "Totale dei beni soggetti a Zakat",
        "hi": "कुल ज़कात योग्य संपत्ति"
    },
    "zakatEnterPriceForNisab": {
        "en": "Enter the gold/silver price to compute the nisab",
        "ar": "أدخل سعر الذهب/الفضة لحساب النصاب",
        "ur": "نصاب کا حساب لگانے کے لیے سونے/چاندی کی قیمت درج کریں",
        "fa": "برای محاسبه نصاب، قیمت طلا یا نقره را وارد کنید",
        "fr": "Saisissez le cours de l'or ou de l'argent pour calculer le nissab",
        "es": "Introduce el precio del oro/plata para calcular el nisab",
        "it": "Inserisci il prezzo dell'oro/argento per calcolare il nisab",
        "hi": "निसाब निकालने के लिए सोने/चांदी का भाव डालें"
    },
    "zakatNisabValue": {
        "en": "Nisab: {amount} {cur}",
        "ar": "النصاب: {amount} {cur}",
        "ur": "نصاب: {amount} {cur}",
        "fa": "نصاب: {amount} {cur}",
        "fr": "Nissab : {amount} {cur}",
        "es": "Nisab: {amount} {cur}",
        "it": "Nisab: {amount} {cur}",
        "hi": "निसाब: {amount} {cur}"
    },
    "zakatDue25": {
        "en": "Zakat due (2.5%)",
        "ar": "الزكاة الواجبة (2.5%)",
        "ur": "واجب الادا زکوٰۃ (2.5%)",
        "fa": "زکات واجب (۲.۵٪)",
        "fr": "Zakat due (2,5%)",
        "es": "Zakat a pagar (2,5%)",
        "it": "Zakat dovuta (2,5%)",
        "hi": "वाजिब ज़कात (2.5%)"
    },
    "zakatHawlCondition": {
        "en": "Provided a full lunar year has passed over it.",
        "ar": "بشرط أن يمرّ على مالك حَوْل كامل (سنة هجرية).",
        "ur": "بشرطیکہ اس مال پر پورا ایک قمری سال (حول) گزر چکا ہو۔",
        "fa": "به شرط آنکه یک سال قمری کامل (حول) بر آن گذشته باشد.",
        "fr": "À condition qu'une année lunaire complète (Hawl) se soit écoulée.",
        "es": "Siempre que haya transcurrido un año lunar completo (Hawl).",
        "it": "A condizione che sia trascorso un anno lunare completo (Hawl).",
        "hi": "शर्त यह है कि इस माल पर पूरा एक हिजरी साल बीत चुका हो।"
    },
    "zakatNotEligibleShort": {
        "en": "Below the nisab ({amount} {cur} short) — no zakat is due now.",
        "ar": "لم يبلغ مالك النصاب (ينقصك {amount} {cur}) فلا زكاة عليك الآن.",
        "ur": "مال نصاب تک نہیں پہنچا ({amount} {cur} کم ہے) — فی الحال زکوٰۃ واجب نہیں۔",
        "fa": "دارایی شما به نصاب نرسیده ({amount} {cur} کسری دارید) — در حال حاضر زکاتی واجب نیست.",
        "fr": "En dessous du nissab (il manque {amount} {cur}) — aucune Zakat due pour le moment.",
        "es": "Por debajo del nisab (faltan {amount} {cur}) — no corresponde Zakat ahora.",
        "it": "Sotto la soglia del nisab (mancano {amount} {cur}) — nessuna Zakat dovuta ora.",
        "hi": "आपकी संपत्ति निसाब तक नहीं पहुँची ({amount} {cur} कम है) — अभी ज़कात फ़र्ज़ नहीं है।"
    },
    "zakatCopyResult": {
        "en": "Copy result",
        "ar": "نسخ النتيجة",
        "ur": "نتیجہ کاپی کریں",
        "fa": "کپی نتیجه",
        "fr": "Copier le résultat",
        "es": "Copiar resultado",
        "it": "Copia risultato",
        "hi": "परिणाम कॉपी करें"
    },
    "zakatResultCopied": {
        "en": "Result copied",
        "ar": "تم نسخ النتيجة",
        "ur": "نتیجہ کاپی ہو گیا",
        "fa": "نتیجه کپی شد",
        "fr": "Résultat copié",
        "es": "Resultado copiado",
        "it": "Risultato copiato",
        "hi": "परिणाम कॉपी हो गया"
    },
    "zakatYearlyReminder": {
        "en": "Yearly zakat reminder",
        "ar": "تذكير سنوي بالزكاة",
        "ur": "سالانہ زکوٰۃ یاد دہانی",
        "fa": "یادآوری سالانه زکات",
        "fr": "Rappel annuel de Zakat",
        "es": "Recordatorio anual de Zakat",
        "it": "Promemoria annuale Zakat",
        "hi": "सालाना ज़कात रिमाइंडर"
    },
    "zakatReminderExplanation": {
        "en": "Pick the date your wealth reached the nisab. We remind you a week before the lunar year completes and on the day, every year (≈354 days).",
        "ar": "اختر تاريخ ما بلغ مالك النصاب، وسنذكّرك قبل تمام الحول بأسبوع ويوم تمامه كل عام (سنة قمرية تقريبية 354 يومًا).",
        "ur": "وہ تاریخ منتخب کریں جب آپ کا مال نصاب کو پہنچا تھا۔ ہم سال مکمل ہونے سے ایک ہفتہ قبل اور اسی دن یاد دلائیں گے۔",
        "fa": "تاریخ رسیدن دارایی به حد نصاب را انتخاب کنید تا یک هفته قبل و در روز اتمام سال قمری به شما یادآوری شود.",
        "fr": "Choisissez la date où vos biens ont atteint le nissab. Nous vous rappellerons une semaine avant et le jour même chaque année lunaire.",
        "es": "Elige la fecha en que tu riqueza alcanzó el nisab. Te avisaremos una semana antes y el día que se cumpla el año lunar.",
        "it": "Scegli la data in cui hai raggiunto il nisab. Ti ricorderemo una settimana prima e il giorno esatto ogni anno lunare.",
        "hi": "वह तारीख चुनें जब आपकी संपत्ति निसाब तक पहुँची थी। हम साल पूरा होने से एक हफ़्ते पहले और उस दिन याद दिलाएँगे।"
    },
    "zakatSetDate": {
        "en": "Set date",
        "ar": "تحديد التاريخ",
        "ur": "تاریخ منتخب کریں",
        "fa": "تعیین تاریخ",
        "fr": "Définir la date",
        "es": "Fijar fecha",
        "it": "Imposta data",
        "hi": "तारीख चुनें"
    },
    "zakatNextDue": {
        "en": "Next due: {date}",
        "ar": "الحَوْل القادم: {date}",
        "ur": "اگلا حول: {date}",
        "fa": "سررسید بعدی: {date}",
        "fr": "Prochaine échéance : {date}",
        "es": "Próximo vencimiento: {date}",
        "it": "Prossima scadenza: {date}",
        "hi": "अगला वर्ष: {date}"
    },
    "zakatScholarsDisclaimer": {
        "en": "Note: general guidance only. For special cases (stocks, companies, debts, trade property…) ask a scholar.",
        "ar": "تنبيه: الحاسبة للإرشاد العام. للحالات الخاصة (أسهم، شركات، ديون، عقارات للتجارة…) راجع أهل العلم في بلدك.",
        "ur": "تنبیہ: یہ کیلکولیٹر عمومی رہنمائی کے لیے ہے۔ خصوصی معاملات (کمپنی شیئرز، جائیدادِ تجارت وغیرہ) کے لیے علماء سے رجوع فرمائیں۔",
        "fa": "تذکر: این محاسبه‌گر صرفاً راهنمای کلی است. برای موارد خاص با علمای دینی مشورت فرمایید.",
        "fr": "Remarque : guide indicatif. Pour les cas particuliers (actions complexes, immobilier commercial...), consultez un savant.",
        "es": "Aviso: guía general. Para casos específicos (acciones, empresas, bienes raíces comerciales...), consulta a un sabio.",
        "it": "Nota: guida generale. Per casi particolari (azioni societarie, immobili commerciali...), consulta uno studioso.",
        "hi": "नोट: यह केवल सामान्य मार्गदर्शन के लिए है। विशेष मामलों के लिए अपने स्थानीय उलेमा से संपर्क करें।"
    },
    "zakatManualPricesTitle": {
        "en": "Manual local prices ({cur})",
        "ar": "أسعار محلية يدوية ({cur})",
        "ur": "مقامی دستی قیمتیں ({cur})",
        "fa": "قیمت‌های محلی دستی ({cur})",
        "fr": "Prix locaux manuels ({cur})",
        "es": "Precios locales manuales ({cur})",
        "it": "Prezzi locali manuali ({cur})",
        "hi": "स्थानीय मैन्युअल भाव ({cur})"
    },
    "zakatManualPricesDesc": {
        "en": "Your local jeweller price may differ from the world price. Enter your own per-gram price, or leave empty to use the automatic one.",
        "ar": "سعر جرام السوق عندك قد يختلف عن السعر العالمي (علاوة الصاغة وفرق سعر الصرف). اكتب سعر الجرام من محلات الصاغة لو حبيت. اتركه فارغًا لاستخدام السعر التلقائي.",
        "ur": "آپ کے مقامی صرافہ بازار کی قیمت عالمی قیمت سے مختلف ہو سکتی ہے۔ فی گرام قیمت خود درج کریں یا خودکار رہنے دیں۔",
        "fa": "قیمت طلافروشی محلی ممکن است با قیمت جهانی فرق کند. قیمت هر گرم را وارد کنید یا خالی بگذارید تا خودکار باشد.",
        "fr": "Le cours chez votre bijoutier local peut différer du cours mondial. Saisissez votre prix au gramme ou laissez vide.",
        "es": "El precio local de joyería puede variar del precio global. Introduce tu precio por gramo o déjalo vacío para usar el automático.",
        "it": "Il prezzo locale dell'orefice può differire da quello mondiale. Inserisci il prezzo al grammo o lascia vuoto.",
        "hi": "आपके स्थानीय सराफ़ा बाज़ार का भाव अलग हो सकता है। अपना प्रति ग्राम भाव डालें या खाली छोड़ दें।"
    },
    "zakatGold24PerGram": {
        "en": "Gold 24k per gram",
        "ar": "جرام الذهب عيار 24",
        "ur": "24 قیراط سونا فی گرام",
        "fa": "هر گرم طلای ۲۴ عیار",
        "fr": "Or 24 carats par gramme",
        "es": "Oro 24k por gramo",
        "it": "Oro 24k al grammo",
        "hi": "24 कैरेट सोना प्रति ग्राम"
    },
    "zakatSilverPerGram": {
        "en": "Silver per gram",
        "ar": "جرام الفضة",
        "ur": "چاندی فی گرام",
        "fa": "هر گرم نقره",
        "fr": "Argent par gramme",
        "es": "Plata por gramo",
        "it": "Argento al grammo",
        "hi": "चांदी प्रति ग्राम"
    },
    "zakatPickHawlHelp": {
        "en": "Date your wealth reached the nisab",
        "ar": "تاريخ ما بلغ مالك النصاب",
        "ur": "وہ تاریخ جب آپ کا مال نصاب تک پہنچا",
        "fa": "تاریخی که داراییتان به نصاب رسید",
        "fr": "Date où vos biens ont atteint le nissab",
        "es": "Fecha en que alcanzaste el nisab",
        "it": "Data in cui hai raggiunto il nisab",
        "hi": "वह तारीख जब संपत्ति निसाब तक पहुँची"
    },
    "zakatSummaryShare": {
        "en": "Zakat — Boshra\nZakatable wealth: {total} {cur}\nNisab ({nisabType}): {nisabVal} {cur}\nZakat due (2.5%): {due} {cur}",
        "ar": "زكاة المال — بُشرى\nإجمالي المال الخاضع للزكاة: {total} {cur}\nالنصاب ({nisabType}): {nisabVal} {cur}\nالزكاة الواجبة (2.5%): {due} {cur}",
        "ur": "زکوٰۃ کیلکولیشن — بُشریٰ ایپ\nکل قابلِ زکوٰۃ مال: {total} {cur}\nنصاب ({nisabType}): {nisabVal} {cur}\nواجب الادا زکوٰۃ (2.5%): {due} {cur}",
        "fa": "محاسبه زکات — برنامه بُشریٰ\nکل اموال مشمول زکات: {total} {cur}\nحد نصاب ({nisabType}): {nisabVal} {cur}\nزکات واجب (۲.۵٪): {due} {cur}",
        "fr": "Zakat — Boshra\nTotal des biens imposables : {total} {cur}\nNissab ({nisabType}) : {nisabVal} {cur}\nZakat due (2,5%) : {due} {cur}",
        "es": "Zakat — Boshra\nBienes sujetos a Zakat: {total} {cur}\nNisab ({nisabType}): {nisabVal} {cur}\nZakat debida (2,5%): {due} {cur}",
        "it": "Zakat — Boshra\nTotale beni imponibili: {total} {cur}\nNisab ({nisabType}): {nisabVal} {cur}\nZakat dovuta (2,5%): {due} {cur}",
        "hi": "ज़कात — बुशरा ऐप\nकुल ज़कात योग्य संपत्ति: {total} {cur}\nनिसाब ({nisabType}): {nisabVal} {cur}\nवाजिब ज़कात (2.5%): {due} {cur}"
    },

    # ------------------ Tracker & Garden & Summary ------------------
    "trackerTitle": {
        "en": "Prayer tracker",
        "ar": "متتبّع الصلوات",
        "ur": "نماز ٹریکر",
        "fa": "پیگیری نمازها",
        "fr": "Suivi des prières",
        "es": "Seguimiento de oraciones",
        "it": "Monitoraggio preghiere",
        "hi": "नमाज़ ट्रैकर"
    },
    "trackerTimeNotStarted": {
        "en": "Its time has not started yet 🌙",
        "ar": "لسه ما دخلش وقتها 🌙",
        "ur": "ابھی اس نماز کا وقت شروع نہیں ہوا 🌙",
        "fa": "هنوز وقت این نماز نرسیده است 🌙",
        "fr": "L'heure de cette prière n'a pas encore commencé 🌙",
        "es": "Aún no ha entrado la hora de esta oración 🌙",
        "it": "L'orario di questa preghiera non è ancora iniziato 🌙",
        "hi": "अभी इस नमाज़ का वक़्त शुरू नहीं हुआ 🌙"
    },
    "trackerLearningHabits": {
        "en": "🧠 Learning your habits",
        "ar": "🧠 بنتعرّف على أنماطك",
        "ur": "🧠 آپ کی عادات کا تجزیہ",
        "fa": "🧠 شناخت الگوهای شما",
        "fr": "🧠 Apprentissage de vos habitudes",
        "es": "🧠 Aprendiendo tus hábitos",
        "it": "🧠 Analisi delle tue abitudini",
        "hi": "🧠 आपकी आदतों का विश्लेषण"
    },
    "trackerLearningDesc": {
        "en": "Log your prayers for at least 5 days, and we will suggest personalized improvements (analyzed only on your device).",
        "ar": "سجّل صلواتك 5 أيام على الأقل، وهنقترح عليك تحسينات تناسبك أنت (كل التحليل على جهازك فقط).",
        "ur": "کم از کم 5 دن تک اپنی نمازیں درج کریں، ہم آپ کے مطابق تجاویز دیں گے (سارا تجزیہ صرف آپ کے فون پر ہوتا ہے)۔",
        "fa": "نمازهای خود را حداقل ۵ روز ثبت کنید تا پیشنهادهای متناسب با خودتان ارائه دهیم (تمام تحلیل فقط روی دستگاه شماست).",
        "fr": "Enregistrez vos prières pendant au moins 5 jours et nous vous suggérerons des améliorations sur mesure (analyse 100% locale).",
        "es": "Registra tus oraciones durante al menos 5 días y te sugeriremos mejoras personalizadas (análisis solo en tu dispositivo).",
        "it": "Registra le tue preghiere per almeno 5 giorni e ti suggeriremo miglioramenti su misura (analisi solo sul dispositivo).",
        "hi": "कम से कम 5 दिन तक अपनी नमाज़ें दर्ज करें, हम आपके अनुकूल सुझाव देंगे (विश्लेषण केवल आपके फ़ोन पर होगा)।"
    },
    "trackerFajrSlips": {
        "en": "🌅 Fajr slips away: {missed} of the last {days} days",
        "ar": "🌅 الفجر بيفوتك: {missed} من آخر {days} يوم",
        "ur": "🌅 فجر قضا ہو رہی ہے: آخری {days} دنوں میں سے {missed} بار",
        "fa": "🌅 فجر از دست می‌رود: {missed} بار از {days} روز گذشته",
        "fr": "🌅 Le Fajr vous échappe : {missed} fois sur les {days} derniers jours",
        "es": "🌅 Se te pasa el Fáyr: {missed} de los últimos {days} días",
        "it": "🌅 Il Fajr ti sfugge: {missed} degli ultimi {days} giorni",
        "hi": "🌅 फ़ज्र छूट रही है: पिछले {days} दिनों में {missed} बार"
    },
    "trackerSleepReminderActive": {
        "en": "Your early-sleep reminder is on at {time} every night 🌿",
        "ar": "تذكير النوم المبكر شغال الساعة {time} كل ليلة. الله يعينك 🌿",
        "ur": "جلدی سونے کی یاد دہانی ہر رات {time} بجے فعال ہے۔ اللہ مدد فرمائے 🌿",
        "fa": "یادآوری خواب زودهنگام هر شب ساعت {time} فعال است 🌿",
        "fr": "Votre rappel pour dormir tôt est actif à {time} chaque soir 🌿",
        "es": "Tu recordatorio de acostarte temprano está activo a las {time} cada noche 🌿",
        "it": "Il promemoria per dormire presto è attivo alle {time} ogni sera 🌿",
        "hi": "जल्दी सोने का रिमाइंडर हर रात {time} बजे चालू है 🌿"
    },
    "trackerSleepReminderSuggest": {
        "en": "Missing Fajr is usually about sleeping late. Want a nightly reminder to sleep early?",
        "ar": "أغلب اللي بيفوّتوا الفجر بيكون السبب السهر. تحب نذكّرك كل ليلة تنام بدري؟",
        "ur": "فجر چھوٹنے کی عام وجہ دیر سے سونا ہے۔ کیا آپ چاہتے ہیں کہ ہم روزانہ رات کو جلدی سونے کی یاد دلائیں؟",
        "fa": "علت اصلی فوت شدن فجر معمولاً دیر خوابیدن است. آیا مایلید هر شب یادآوری خواب زودهنگام دریافت کنید؟",
        "fr": "Manquer le Fajr est souvent dû au coucher tardif. Voulez-vous un rappel pour dormir tôt chaque soir ?",
        "es": "Perderse el Fáyr suele deberse a trasnochar. ¿Deseas un recordatorio nocturno para dormir temprano?",
        "it": "Perdere il Fajr è spesso dovuto al dormire tardi. Vuoi un promemoria serale per dormire presto?",
        "hi": "फ़ज्र छूटने की मुख्य वजह देर से सोना है। क्या आप हर रात जल्दी सोने का रिमाइंडर चाहते हैं?"
    },
    "trackerTurnOnTime": {
        "en": "Turn on ({time})",
        "ar": "فعّل ({time})",
        "ur": "فعال کریں ({time})",
        "fa": "فعال‌سازی ({time})",
        "fr": "Activer ({time})",
        "es": "Activar ({time})",
        "it": "Attiva ({time})",
        "hi": "चालू करें ({time})"
    },
    "trackerNotNow": {
        "en": "Not now",
        "ar": "مش دلوقتي",
        "ur": "ابھی نہیں",
        "fa": "الان نه",
        "fr": "Pas maintenant",
        "es": "Ahora no",
        "it": "Non ora",
        "hi": "अभी नहीं"
    },
    "trackerChangeTime": {
        "en": "Change time",
        "ar": "غيّر الوقت",
        "ur": "وقت بدلیں",
        "fa": "تغییر زمان",
        "fr": "Changer l'heure",
        "es": "Cambiar hora",
        "it": "Modifica orario",
        "hi": "समय बदलें"
    },
    "trackerTurnOff": {
        "en": "Turn off",
        "ar": "إيقاف",
        "ur": "بند کریں",
        "fa": "خاموش کردن",
        "fr": "Désactiver",
        "es": "Desactivar",
        "it": "Disattiva",
        "hi": "बंद करें"
    },
    "trackerPickAnotherTime": {
        "en": "Pick another time",
        "ar": "اختر وقتًا آخر",
        "ur": "کوئی دوسرا وقت منتخب کریں",
        "fa": "زمان دیگری انتخاب کنید",
        "fr": "Choisir une autre heure",
        "es": "Elegir otra hora",
        "it": "Scegli un altro orario",
        "hi": "दूसरा समय चुनें"
    },
    "trackerPrayerNearEnd": {
        "en": "⏰ {prayer} is usually near the end of its time",
        "ar": "⏰ {prayer} غالبًا في آخر وقتها",
        "ur": "⏰ {prayer} اکثر آخری وقت میں ادا ہو رہی ہے",
        "fa": "⏰ {prayer} معمولاً در اواخر وقت خوانده می‌شود",
        "fr": "⏰ {prayer} est souvent accomplie vers la fin de son heure",
        "es": "⏰ {prayer} suele rezarse cerca del final de su hora",
        "it": "⏰ {prayer} viene spesso pregata verso la fine del suo tempo",
        "hi": "⏰ {prayer} अक्सर अंतिम समय में पढ़ी जा रही है"
    },
    "trackerPrayerNearEndDesc": {
        "en": "Your gentle reminder for {prayer} now arrives earlier (mid-window instead of near the end).",
        "ar": "خلّينا التذكير اللطيف لـ {prayer} يجيلك أبكر من المعتاد (منتصف الوقت بدل آخره).",
        "ur": "ہم نے {prayer} کی ہلکی یاد دہانی کو وقت کے درمیان میں کر دیا تاکہ نماز قضا نہ ہو۔",
        "fa": "یادآوری ملایم {prayer} را زودتر تنظیم کردیم (میانه وقت به جای پایان).",
        "fr": "Le rappel doux pour {prayer} arrive désormais plus tôt (au milieu plutôt qu'à la fin).",
        "es": "El recordatorio suave para {prayer} llegará antes (a mitad del tiempo).",
        "it": "Il promemoria per {prayer} ora arriverà prima (a metà finestra invece che alla fine).",
        "hi": "हमने {prayer} का रिमाइंडर पहले (मध्य समय में) कर दिया है ताकि नमाज़ समय पर हो।"
    },
    "trackerGreatConsistency": {
        "en": "✨ Great consistency",
        "ar": "✨ مواظبتك ممتازة",
        "ur": "✨ آپ کی پابندی شاندار ہے",
        "fa": "✨ پایداری شما عالی است",
        "fr": "✨ Excellente régularité",
        "es": "✨ Excelente constancia",
        "it": "✨ Ottima costanza",
        "hi": "✨ आपकी पाबंदी बहुत अच्छी है"
    },
    "trackerWeakestPrayer": {
        "en": "🌿 Your weakest prayer: {prayer}",
        "ar": "🌿 أضعف صلواتك: {prayer}",
        "ur": "🌿 سب سے زیادہ قضا ہونے والی نماز: {prayer}",
        "fa": "🌿 نیازمند توجه بیشتر: {prayer}",
        "fr": "🌿 Prière la moins régulière : {prayer}",
        "es": "🌿 Oración que más descuidas: {prayer}",
        "it": "🌿 Preghiera meno frequente: {prayer}",
        "hi": "🌿 जिस नमाज़ पर ध्यान चाहिए: {prayer}"
    },
    "trackerNoPrayerSlipping": {
        "en": "No prayer is slipping repeatedly. Keep going!",
        "ar": "مفيش صلاة بتفوتك بشكل متكرر. استمر!",
        "ur": "کوئی نماز بار بار نہیں چھوٹ رہی۔ ماشاءاللہ جاری رکھیں!",
        "fa": "هیچ نمازی به طور مکرر قضا نمی‌شود. ادامه دهید!",
        "fr": "Aucune prière ne vous échappe régulièrement. Continuez ainsi !",
        "es": "Ninguna oración se te escapa habitualmente. ¡Sigue así!",
        "it": "Nessuna preghiera viene persa ripetutamente. Continua così!",
        "hi": "कोई भी नमाज़ बार-बार नहीं छूट रही। बहुत बढ़िया, जारी रखें!"
    },
    "trackerPrayerMissedCount": {
        "en": "Missed {missed} times in the last {days} days. The gentle reminder helps.",
        "ar": "فاتتك {missed} مرات في آخر {days} يوم. التذكير اللطيف بيساعدك عليها.",
        "ur": "آخری {days} دنوں میں {missed} بار چھوٹ گئی۔ نرم یاد دہانی اس میں مدد کرے گی۔",
        "fa": "{missed} بار در {days} روز اخیر از دست رفته. یادآوری ملایم به شما کمک می‌کند.",
        "fr": "Manquée {missed} fois sur les {days} derniers jours. Le rappel doux vous aide.",
        "es": "Perdida {missed} veces en los últimos {days} días. El recordatorio suave te ayudará.",
        "it": "Mancata {missed} volte negli ultimi {days} giorni. Il promemoria gentile ti aiuterà.",
        "hi": "पिछले {days} दिनों में {missed} बार छूटी। जेंटल रिमाइंडर आपकी मदद करेगा।"
    },
    "trackerTurnOffNudge": {
        "en": "Turn off gentle reminder",
        "ar": "إيقاف التذكير اللطيف",
        "ur": "نرم یاد دہانی بند کریں",
        "fa": "خاموش کردن یادآوری ملایم",
        "fr": "Désactiver le rappel doux",
        "es": "Desactivar recordatorio suave",
        "it": "Disattiva promemoria gentile",
        "hi": "जेंटल रिमाइंडर बंद करें"
    },
    "trackerTurnOnNudge": {
        "en": "Turn on gentle reminder",
        "ar": "تفعيل التذكير اللطيف",
        "ur": "نرم یاد دہانی چالو کریں",
        "fa": "فعال کردن یادآوری ملایم",
        "fr": "Activer le rappel doux",
        "es": "Activar recordatorio suave",
        "it": "Attiva promemoria gentile",
        "hi": "जेंटल रिमाइंडर चालू करें"
    },
    "trackerStopLearning": {
        "en": "Stop learning my habits",
        "ar": "إيقاف تعلّم أنماطي",
        "ur": "میری عادات کا تجزیہ بند کریں",
        "fa": "توقف یادگیری الگوهای من",
        "fr": "Arrêter l'analyse des habitudes",
        "es": "Dejar de aprender mis hábitos",
        "it": "Interrompi analisi abitudini",
        "hi": "मेरी आदतों का विश्लेषण रोकें"
    },
    "trackerStartLearning": {
        "en": "Learn my habits",
        "ar": "تفعيل تعلّم أنماطي",
        "ur": "میری عادات کا تجزیہ فعال کریں",
        "fa": "یادگیری الگوهای من",
        "fr": "Analyser mes habitudes",
        "es": "Aprender mis hábitos",
        "it": "Analizza le mie abitudini",
        "hi": "मेरी आदतों का विश्लेषण चालू करें"
    },
    "trackerStartStreakToday": {
        "en": "Start your streak today",
        "ar": "ابدأ سلسلتك اليوم",
        "ur": "آج سے اپنا سلسلہ شروع کریں",
        "fa": "زنجیره خود را امروز آغاز کنید",
        "fr": "Commencez votre série aujourd'hui",
        "es": "Empieza tu racha hoy",
        "it": "Inizia la tua serie oggi",
        "hi": "आज से अपनी लड़ी शुरू करें"
    },
    "trackerStreakDays": {
        "en": "{count}-day streak, all five prayers",
        "ar": "{count} أيام متتالية بكل الصلوات",
        "ur": "مسلسل {count} دن تمام پانچوں نمازیں",
        "fa": "{count} روز متوالی هر پنج نماز",
        "fr": "Série de {count} jours, les cinq prières",
        "es": "Racha de {count} días, las cinco oraciones",
        "it": "Serie di {count} giorni, tutte e cinque le preghiere",
        "hi": "लगातार {count} दिन, सभी पाँचों नमाज़ें"
    },
    "trackerBestStreakStats": {
        "en": "Best streak: {best} — this week: {pct}%",
        "ar": "أفضل سلسلة: {best} — هذا الأسبوع: {pct}%",
        "ur": "بہترین سلسلہ: {best} — اس ہفتے: {pct}%",
        "fa": "بهترین زنجیره: {best} — این هفته: {pct}%",
        "fr": "Meilleure série : {best} — cette semaine : {pct}%",
        "es": "Mejor racha: {best} — esta semana: {pct}%",
        "it": "Miglior serie: {best} — questa settimana: {pct}%",
        "hi": "सर्वश्रेष्ठ स्ट्रीक: {best} — इस सप्ताह: {pct}%"
    },
    "trackerToday": {
        "en": "Today",
        "ar": "اليوم",
        "ur": "آج",
        "fa": "امروز",
        "fr": "Aujourd'hui",
        "es": "Hoy",
        "it": "Oggi",
        "hi": "आज"
    },
    "trackerYesterday": {
        "en": "Yesterday",
        "ar": "أمس",
        "ur": "کل (گزشتہ)",
        "fa": "دیروز",
        "fr": "Hier",
        "es": "Ayer",
        "it": "Ieri",
        "hi": "कल (बीता हुआ)"
    },
    "trackerYourGarden": {
        "en": "Your garden 🌳",
        "ar": "حديقتك 🌳",
        "ur": "آپ کا باغ 🌳",
        "fa": "باغ شما 🌳",
        "fr": "Votre jardin 🌳",
        "es": "Tu jardín 🌳",
        "it": "Il tuo giardino 🌳",
        "hi": "आपका बाग़ीचा 🌳"
    },
    "trackerGardenDesc": {
        "en": "Every prayer has a tree that grows with each day you keep it",
        "ar": "كل صلاة ليها شجرة بتكبر مع كل يوم تواظب فيه عليها",
        "ur": "ہر نماز کا ایک درخت ہے جو آپ کی پابندی کے ساتھ بڑھتا ہے",
        "fa": "هر نماز درختی دارد که با پایبندی روزانه شما رشد می‌کند",
        "fr": "Chaque prière a son arbre qui grandit à mesure que vous êtes assidu",
        "es": "Cada oración tiene un árbol que crece cada día que eres constante",
        "it": "Ogni preghiera ha un albero che cresce ogni giorno di costanza",
        "hi": "हर नमाज़ का एक पेड़ है जो आपकी पाबंदी के साथ बड़ा होता है"
    },
    "trackerDayUnit": {
        "en": "d",
        "ar": "يوم",
        "ur": "دن",
        "fa": "روز",
        "fr": "j",
        "es": "d",
        "it": "g",
        "hi": "दिन"
    },
    "trackerTodayPrayers": {
        "en": "Today's prayers",
        "ar": "صلوات اليوم",
        "ur": "آج کی نمازیں",
        "fa": "نمازهای امروز",
        "fr": "Prières d'aujourd'hui",
        "es": "Oraciones de hoy",
        "it": "Preghiere di oggi",
        "hi": "आज की नमाज़ें"
    },
    "trackerPrayersOnDate": {
        "en": "Prayers {date}",
        "ar": "صلوات {date}",
        "ur": "نمازیں {date}",
        "fa": "نمازهای {date}",
        "fr": "Prières du {date}",
        "es": "Oraciones del {date}",
        "it": "Preghiere del {date}",
        "hi": "नमाज़ें {date}"
    },
    "trackerPrayedMark": {
        "en": "Prayed ✓",
        "ar": "صلّيت ✓",
        "ur": "پڑھ لی ✓",
        "fa": "خوانده شد ✓",
        "fr": "Priée ✓",
        "es": "Rezată ✓",
        "it": "Pregata ✓",
        "hi": "अदा की ✓"
    },
    "trackerNotMarked": {
        "en": "Not marked",
        "ar": "لم تُسجَّل",
        "ur": "درج نہیں ہوئی",
        "fa": "ثبت نشده",
        "fr": "Non marquée",
        "es": "No marcada",
        "it": "Non registrata",
        "hi": "दर्ज नहीं"
    },
    "trackerThisWeek": {
        "en": "This week",
        "ar": "إحصائيات الأسبوع",
        "ur": "اس ہفتے کے اعداد و شمار",
        "fa": "آمار این هفته",
        "fr": "Cette semaine",
        "es": "Esta semana",
        "it": "Questa settimana",
        "hi": "इस सप्ताह के आंकड़े"
    },
    "trackerTotalPrayedCount": {
        "en": "Total logged: {count} prayers",
        "ar": "إجمالي ما سجّلته: {count} صلاة",
        "ur": "کل درج شدہ نمازیں: {count}",
        "fa": "مجموع ثبت شده: {count} نماز",
        "fr": "Total enregistré : {count} prières",
        "es": "Total registrado: {count} oraciones",
        "it": "Totale registrato: {count} preghiere",
        "hi": "कुल दर्ज नमाज़ें: {count}"
    },
    "gardenTitle": {
        "en": "My garden",
        "ar": "حديقتي",
        "ur": "میرا باغ",
        "fa": "باغ من",
        "fr": "Mon jardin",
        "es": "Mi jardín",
        "it": "Il mio giardino",
        "hi": "मेरा बाग़"
    },
    "gardenHomeCardTitle": {
        "en": "Your prayer garden 🌳",
        "ar": "حديقة صلواتك 🌳",
        "ur": "آپ کا نماز کا باغ 🌳",
        "fa": "باغ نمازهای شما 🌳",
        "fr": "Votre jardin de prières 🌳",
        "es": "Tu jardín de oraciones 🌳",
        "it": "Il tuo giardino di preghiere 🌳",
        "hi": "आपका नमाज़ बाग़ीचा 🌳"
    },
    "gardenEnterFull": {
        "en": "Enter your full garden 🌿",
        "ar": "ادخل حديقتك الكاملة 🌿",
        "ur": "اپنے مکمل باغ میں داخل ہوں 🌿",
        "fa": "ورود به باغ کامل 🌿",
        "fr": "Entrer dans votre jardin complet 🌿",
        "es": "Entrar a tu jardín completo 🌿",
        "it": "Entra nel tuo giardino completo 🌿",
        "hi": "अपने पूरे बाग़ीचे में जाएँ 🌿"
    },
    "gardenTooEarlySeed": {
        "en": "Too early… the seed is waiting 🌱",
        "ar": "لسه بدري… البذرة بتستنّاك 🌱",
        "ur": "ابھی وقت باقی ہے… بیج منتظر ہے 🌱",
        "fa": "هنوز زود است… بذر منتظر شماست 🌱",
        "fr": "Trop tôt… la graine attend 🌱",
        "es": "Demasiado pronto… la semilla espera 🌱",
        "it": "Troppo presto… il seme attende 🌱",
        "hi": "अभी समय है… बीज इंतज़ार कर रहा है 🌱"
    },
    "gardenChooseMonth": {
        "en": "Choose the month",
        "ar": "اختر الشهر",
        "ur": "مہینہ منتخب کریں",
        "fa": "انتخاب ماه",
        "fr": "Choisir le mois",
        "es": "Elegir el mes",
        "it": "Scegli il mese",
        "hi": "महीना चुनें"
    },
    "gardenOf": {
        "en": "Garden of",
        "ar": "حديقة",
        "ur": "باغِ",
        "fa": "باغِ",
        "fr": "Jardin de",
        "es": "Jardín de",
        "it": "Giardino di",
        "hi": "बाग़:"
    },
    "gardenHijriSuffix": {
        "en": "AH",
        "ar": "هـ",
        "ur": "ھ",
        "fa": "ق",
        "fr": "H",
        "es": "H",
        "it": "H",
        "hi": "हिजरी"
    },
    "gardenPerfectDaysCount": {
        "en": "{count} perfect days",
        "ar": "{count} أيام كاملة",
        "ur": "{count} مکمل دن",
        "fa": "{count} روز کامل",
        "fr": "{count} jours parfaits",
        "es": "{count} días perfectos",
        "it": "{count} giorni perfetti",
        "hi": "{count} संपूर्ण दिन"
    },
    "gardenBestStreakCount": {
        "en": "Best streak {count}",
        "ar": "أفضل سلسلة {count}",
        "ur": "بہترین سلسلہ {count}",
        "fa": "بهترین زنجیره {count}",
        "fr": "Meilleure série {count}",
        "es": "Mejor racha {count}",
        "it": "Miglior serie {count}",
        "hi": "सर्वश्रेष्ठ लड़ी {count}"
    },
    "gardenBlessedForest": {
        "en": "A blessed forest",
        "ar": "غابة مباركة",
        "ur": "ایک بابرکت جنگل",
        "fa": "جنگلی با برکت",
        "fr": "Une forêt bénie",
        "es": "Un bosque bendito",
        "it": "Una foresta benedetta",
        "hi": "एक बरकत भरा बाग़"
    },
    "gardenWeekNumber": {
        "en": "Week {num}",
        "ar": "الأسبوع {num}",
        "ur": "ہفتہ {num}",
        "fa": "هفته {num}",
        "fr": "Semaine {num}",
        "es": "Semana {num}",
        "it": "Settimana {num}",
        "hi": "सप्ताह {num}"
    },
    "gardenMsgFlourishing": {
        "en": "Masha Allah! A flourishing garden 🌳🌳🌳",
        "ar": "ما شاء الله! حديقة عامرة مباركة 🌳🌳🌳",
        "ur": "ماشاءاللہ! ایک سرسبز و شاداب باغ 🌳🌳🌳",
        "fa": "ماشاءالله! باغی سرسبز و پربار 🌳🌳🌳",
        "fr": "Machallah ! Un jardin florissant 🌳🌳🌳",
        "es": "¡Masha Allah! Un jardín floreciente 🌳🌳🌳",
        "it": "Masha Allah! Un giardino rigoglioso 🌳🌳🌳",
        "hi": "माशाअल्लाह! एक हरा-भरा और सुंदर बाग़ 🌳🌳🌳"
    },
    "gardenMsgKeepGoing": {
        "en": "A lovely garden — keep going and it becomes a forest 🌿",
        "ar": "حديقتك جميلة — كمّل وهتبقى غابة 🌿",
        "ur": "آپ کا باغ خوبصورت ہے — جاری رکھیں، یہ ایک بڑا باغ بن جائے گا 🌿",
        "fa": "باغ زیبایی است — ادامه دهید تا جنگلی انبوه شود 🌿",
        "fr": "Un beau jardin — continuez pour en faire une forêt 🌿",
        "es": "Un hermoso jardín — sigue así y se convertirá en un bosque 🌿",
        "it": "Un bel giardino — continua così e diventerà una foresta 🌿",
        "hi": "सुंदर बाग़ीचा — ऐसे ही जारी रखें, यह घना बाग़ बनेगा 🌿"
    },
    "gardenMsgWaterToday": {
        "en": "Every prayer waters a tree. Start today 💧",
        "ar": "كل صلاة بتسقي شجرة. ابدأ من النهارده 💧",
        "ur": "ہر نماز درخت کو پانی دیتی ہے۔ آج ہی سے شروع کریں 💧",
        "fa": "هر نماز به درختی آب می‌دهد. از امروز شروع کنید 💧",
        "fr": "Chaque prière arrose un arbre. Commencez dès aujourd'hui 💧",
        "es": "Cada oración riega un árbol. Empieza hoy 💧",
        "it": "Ogni preghiera innaffia un albero. Inizia oggi 💧",
        "hi": "हर नमाज़ पेड़ को सींचती है। आज से ही शुरू करें 💧"
    },
    "gardenMsgWaitingFirst": {
        "en": "The garden is waiting… your first prayer plants the first tree 🌱",
        "ar": "الحديقة مستنياك… أول صلاة تزرع أول شجرة 🌱",
        "ur": "باغ منتظر ہے… پہلی نماز پہلا پودا لگائے گی 🌱",
        "fa": "باغ منتظر شماست… اولین نماز، کاشت اولین درخت است 🌱",
        "fr": "Le jardin vous attend… votre première prière plante le premier arbre 🌱",
        "es": "El jardín espera… tu primera oración planta el primer árbol 🌱",
        "it": "Il giardino ti aspetta… la prima preghiera pianta il primo albero 🌱",
        "hi": "बाग़ीचा इंतज़ार कर रहा है… पहली नमाज़ पहला पौधा रोपेगी 🌱"
    },
    "plantStatusPrayedAt": {
        "en": "Prayed ✓ at {time}",
        "ar": "صلّيتها ✓ الساعة {time}",
        "ur": "پڑھ لی ✓ {time} پر",
        "fa": "خوانده شد ✓ ساعت {time}",
        "fr": "Priée ✓ à {time}",
        "es": "Rezată ✓ a las {time}",
        "it": "Pregata ✓ alle {time}",
        "hi": "अदा की ✓ समय {time}"
    },
    "plantStatusPrayed": {
        "en": "Prayed ✓",
        "ar": "صلّيتها ✓",
        "ur": "پڑھ لی ✓",
        "fa": "خوانده شد ✓",
        "fr": "Priée ✓",
        "es": "Rezată ✓",
        "it": "Pregata ✓",
        "hi": "अदा की ✓"
    },
    "plantStatusPending": {
        "en": "Its time has come — not logged yet 💧",
        "ar": "وقتها دخل ولسه ما سجّلتهاش 💧",
        "ur": "وقت شروع ہو گیا ہے — ابھی درج نہیں کی 💧",
        "fa": "وقتش رسیده و هنوز ثبت نشده 💧",
        "fr": "Son heure est entrée — pas encore notée 💧",
        "es": "Ya es su hora — aún no registrada 💧",
        "it": "L'orario è giunto — non ancora registrata 💧",
        "hi": "वक़्त हो चुका है — अभी दर्ज नहीं किया 💧"
    },
    "plantStatusMissed": {
        "en": "Not logged — the tree needs water",
        "ar": "لم تُسجَّل — الشجرة محتاجة سقاية",
        "ur": "درج نہیں ہوئی — درخت کو پانی کی ضرورت ہے",
        "fa": "ثبت نشده — درخت تشنه آب است",
        "fr": "Non notée — l'arbre a besoin d'eau",
        "es": "No registrada — el árbol necesita agua",
        "it": "Non registrata — l'albero ha bisogno d'acqua",
        "hi": "दर्ज नहीं — पौधे को पानी की ज़रूरत है"
    },
    "plantStatusUpcoming": {
        "en": "Its time has not come yet 🌱",
        "ar": "لسه وقتها ما جاش 🌱",
        "ur": "ابھی وقت نہیں ہوا 🌱",
        "fa": "هنوز وقتش نرسیده است 🌱",
        "fr": "Son heure n'est pas encore venue 🌱",
        "es": "Aún no es la hora 🌱",
        "it": "Non è ancora l'ora 🌱",
        "hi": "अभी वक़्त नहीं हुआ 🌱"
    },
    "plantStreakFruit": {
        "en": "A fruit-bearing tree! {streak} days in a row on {prayer} 🍎",
        "ar": "شجرة مثمرة! {streak} يوم متواصل على {prayer} 🍎",
        "ur": "پھلدار درخت! {prayer} پر مسلسل {streak} دن 🍎",
        "fa": "درخت میوه‌دار! {streak} روز متوالی در {prayer} 🍎",
        "fr": "Un arbre fruitier ! {streak} jours d'affilée pour {prayer} 🍎",
        "es": "¡Árbol frutal! {streak} días seguidos en {prayer} 🍎",
        "it": "Un albero da frutto! {streak} giorni consecutivi per {prayer} 🍎",
        "hi": "फलदार पेड़! {prayer} पर लगातार {streak} दिन 🍎"
    },
    "plantStreakWeekPlus": {
        "en": "{streak} days in a row on {prayer} 🔥",
        "ar": "أسبوع فأكثر — {streak} يوم متواصل على {prayer} 🔥",
        "ur": "ایک ہفتہ یا زائد — {prayer} پر مسلسل {streak} دن 🔥",
        "fa": "یک هفته یا بیشتر — {streak} روز متوالی در {prayer} 🔥",
        "fr": "{streak} jours consécutifs pour {prayer} 🔥",
        "es": "{streak} días seguidos en {prayer} 🔥",
        "it": "{streak} giorni di fila per {prayer} 🔥",
        "hi": "{prayer} पर लगातार {streak} दिन 🔥"
    },
    "plantStreakDayNum": {
        "en": "Day {streak} of your streak on {prayer}",
        "ar": "اليوم رقم {streak} من مواظبتك على {prayer}",
        "ur": "{prayer} کی پابندی کا دن نمبر {streak}",
        "fa": "روز شماره {streak} از پایداری در {prayer}",
        "fr": "Jour {streak} de votre série sur {prayer}",
        "es": "Día {streak} de tu racha en {prayer}",
        "it": "Giorno {streak} della tua serie per {prayer}",
        "hi": "{prayer} की स्ट्रीक का {streak}वां दिन"
    },
    "plantWaterConsistency": {
        "en": "Every prayer grows the tree — consistency is its water 💧",
        "ar": "كل صلاة بتكبّر الشجرة — مواظبتك هي مياهها 💧",
        "ur": "ہر نماز درخت کو بڑا کرتی ہے — آپ کی پابندی اس کا پانی ہے 💧",
        "fa": "هر نماز درخت را رشد می‌دهد — پایبندی شما آب حیات آن است 💧",
        "fr": "Chaque prière fait grandir l'arbre — votre assiduité est son eau 💧",
        "es": "Cada oración hace crecer el árbol — tu constancia es su agua 💧",
        "it": "Ogni preghiera fa crescere l'albero — la costanza è la sua acqua 💧",
        "hi": "हर नमाज़ पौधे को बड़ा करती है — आपकी पाबंदी ही इसका पानी है 💧"
    },
    "plantUndo": {
        "en": "Undo",
        "ar": "إلغاء التسجيل",
        "ur": "منسوخ کریں",
        "fa": "لغو ثبت",
        "fr": "Annuler",
        "es": "Deshacer",
        "it": "Annulla",
        "hi": "वापस लें"
    },
    "plantWaterAction": {
        "en": "I prayed it — water the tree 💧",
        "ar": "سجّلتها — اسقِ الشجرة 💧",
        "ur": "میں نے پڑھ لی — پودے کو پانی دیں 💧",
        "fa": "خواندم — آبیاری درخت 💧",
        "fr": "Je l'ai priée — arroser l'arbre 💧",
        "es": "La he rezado — regar el árbol 💧",
        "it": "Ho pregato — innaffia l'albero 💧",
        "hi": "मैंने नमाज़ पढ़ी — पौधे को सींचें 💧"
    },
    "plantStageSeed": {
        "en": "Seed",
        "ar": "بذرة",
        "ur": "بیج",
        "fa": "بذر",
        "fr": "Graine",
        "es": "Semilla",
        "it": "Seme",
        "hi": "बीज"
    },
    "plantStageSprout": {
        "en": "Sprout",
        "ar": "برعم",
        "ur": "کونپل",
        "fa": "جوانه",
        "fr": "Pousse",
        "es": "Brote",
        "it": "Germoglio",
        "hi": "अंकुर"
    },
    "plantStageSapling": {
        "en": "Sapling",
        "ar": "شتلة",
        "ur": "پودا",
        "fa": "نهال",
        "fr": "Jeune pousse",
        "es": "Plántula",
        "it": "Arbusto",
        "hi": "पौधा"
    },
    "plantStageYoungTree": {
        "en": "Young tree",
        "ar": "شجرة صغيرة",
        "ur": "چھوٹا درخت",
        "fa": "درختچه",
        "fr": "Jeune arbre",
        "es": "Árbol joven",
        "it": "Alberello",
        "hi": "छोटा पेड़"
    },
    "plantStageTree": {
        "en": "Tree",
        "ar": "شجرة",
        "ur": "درخت",
        "fa": "درخت",
        "fr": "Arbre",
        "es": "Árbol",
        "it": "Albero",
        "hi": "पेड़"
    },
    "plantStageFruitTree": {
        "en": "Fruit tree",
        "ar": "شجرة مثمرة",
        "ur": "پھلدار درخت",
        "fa": "درخت میوه",
        "fr": "Arbre fruitier",
        "es": "Árbol frutal",
        "it": "Albero da frutto",
        "hi": "फलदार पेड़"
    },
    "treeCherryBlossom": {
        "en": "Cherry blossom",
        "ar": "شجرة الكرز",
        "ur": "چیری کا درخت",
        "fa": "درخت گیلاس",
        "fr": "Cerisier en fleur",
        "es": "Cerezo en flor",
        "it": "Ciliegio in fiore",
        "hi": "चेरी ब्लॉसम"
    },
    "treeDatePalm": {
        "en": "Date palm",
        "ar": "النخلة",
        "ur": "کھجور کا درخت",
        "fa": "نخل خرما",
        "fr": "Palmier dattier",
        "es": "Palmera datilera",
        "it": "Palma da dattero",
        "hi": "खजूर का पेड़"
    },
    "treeOrangeTree": {
        "en": "Orange tree",
        "ar": "شجرة البرتقال",
        "ur": "مالٹے کا درخت",
        "fa": "درخت پرتقال",
        "fr": "Oranger",
        "es": "Naranjo",
        "it": "Arancio",
        "hi": "संतरे का पेड़"
    },
    "treePomegranate": {
        "en": "Pomegranate",
        "ar": "شجرة الرمان",
        "ur": "انار کا درخت",
        "fa": "درخت انار",
        "fr": "Grenadier",
        "es": "Granado",
        "it": "Melograno",
        "hi": "अनार का पेड़"
    },
    "treeCypress": {
        "en": "Cypress",
        "ar": "السروة",
        "ur": "سرو کا درخت",
        "fa": "سرو",
        "fr": "Cyprès",
        "es": "Ciprés",
        "it": "Cipresso",
        "hi": "सनोबर का पेड़"
    },
    "weeklySummaryTitle": {
        "en": "Weekly summary",
        "ar": "ملخّصك الأسبوعي",
        "ur": "ہفتہ وار خلاصہ",
        "fa": "خلاصه هفتگی شما",
        "fr": "Bilan hebdomadaire",
        "es": "Resumen semanal",
        "it": "Riepilogo settimanale",
        "hi": "साप्ताहिक सारांश"
    },
    "weeklyShareAsImage": {
        "en": "Share as image",
        "ar": "مشاركة كصورة",
        "ur": "تصویر کے طور پر شیئر کریں",
        "fa": "اشتراک‌گذاری به عنوان تصویر",
        "fr": "Partager comme image",
        "es": "Compartir como imagen",
        "it": "Condividi come immagine",
        "hi": "फ़ोटो के रूप में शेयर करें"
    },
    "weeklyNoPrayersLogged": {
        "en": "No prayers logged this week yet. Start from your garden on Home 🌱",
        "ar": "لسه ما سجّلتش صلوات هذا الأسبوع. ابدأ من «حديقة صلواتك» في الرئيسية 🌱",
        "ur": "اس ہفتے ابھی تک کوئی نماز درج نہیں ہوئی۔ ہوم اسکرین کے باغیچے سے آغاز کریں 🌱",
        "fa": "این هفته هنوز نمازی ثبت نشده. از باغچه صفحه اصلی شروع کنید 🌱",
        "fr": "Aucune prière enregistrée cette semaine. Commencez depuis votre jardin sur l'accueil 🌱",
        "es": "Aún no has registrado oraciones esta semana. Comienza desde tu jardín en el inicio 🌱",
        "it": "Nessuna preghiera registrata questa settimana. Inizia dal tuo giardino nella Home 🌱",
        "hi": "इस हफ़्ते अभी तक कोई नमाज़ दर्ज नहीं हुई। होम स्क्रीन के बाग़ीचे से शुरुआत करें 🌱"
    },
    "weeklyShareYourTree": {
        "en": "Share your weekly tree",
        "ar": "شارك شجرة أسبوعك",
        "ur": "اپنے ہفتے کا درخت شیئر کریں",
        "fa": "درخت هفتگی خود را به اشتراک بگذارید",
        "fr": "Partager votre arbre de la semaine",
        "es": "Comparte tu árbol semanal",
        "it": "Condividi il tuo albero settimanale",
        "hi": "अपने हफ़्ते का पेड़ शेयर करें"
    },
    "weeklyNotificationHint": {
        "en": "Every Friday evening you get a notification with your weekly summary.",
        "ar": "كل جمعة بعد العشاء بيجيلك إشعار بملخّص أسبوعك. تقدر تشاركه صدقة جارية لتشجيع غيرك.",
        "ur": "ہر جمعہ عشاء کے بعد آپ کو ہفتہ وار خلاصے کی اطلاع ملتی ہے۔ دوسروں کی ترغیب کے لیے اسے شیئر کریں۔",
        "fa": "هر جمعه بعد از عشاء اعلانی با خلاصه هفته دریافت می‌کنید.",
        "fr": "Chaque vendredi soir après l'Isha, recevez une notification avec votre résumé hebdomadaire.",
        "es": "Cada viernes después de Isha recibes una notificación con tu resumen semanal.",
        "it": "Ogni venerdì sera dopo l'Isha riceverai una notifica con il tuo riepilogo settimanale.",
        "hi": "हर जुमा ईशा के बाद आपको अपने हफ़्ते का सारांश मिलता है।"
    },
    "weeklyImageError": {
        "en": "Could not create the image, try again",
        "ar": "تعذّر إنشاء الصورة، حاول مرة أخرى",
        "ur": "تصویر بنانے میں ناکامی، دوبارہ کوشش کریں",
        "fa": "ایجاد تصویر ممکن نشد، دوباره تلاش کنید",
        "fr": "Impossible de créer l'image, réessayez",
        "es": "No se pudo generar la imagen, inténtalo de nuevo",
        "it": "Impossibile creare l'immagine, riprova",
        "hi": "फ़ोटो तैयार नहीं हो सकी, कृपया दोबारा प्रयास करें"
    },
    "weeklyCardTitle": {
        "en": "My weekly summary",
        "ar": "ملخّصي الأسبوعي",
        "ur": "میرا ہفتہ وار خلاصہ",
        "fa": "خلاصه هفتگی من",
        "fr": "Mon bilan hebdomadaire",
        "es": "Mi resumen semanal",
        "it": "Il mio riepilogo settimanale",
        "hi": "मेरा साप्ताहिक सारांश"
    },
    "weeklyCardTreeSubtitle": {
        "en": "My prayer tree this week 🌳",
        "ar": "شجرة صلواتي هذا الأسبوع 🌳",
        "ur": "اس ہفتے میرا نماز کا درخت 🌳",
        "fa": "درخت نمازهای من در این هفته 🌳",
        "fr": "Mon arbre de prières cette semaine 🌳",
        "es": "Mi árbol de oraciones esta semana 🌳",
        "it": "Il mio albero delle preghiere questa settimana 🌳",
        "hi": "इस सप्ताह मेरा नमाज़ का पेड़ 🌳"
    },
    "weeklyCardPercentLogged": {
        "en": "{pct}% of my prayers logged",
        "ar": "{pct}% من صلواتي في وقتها بإذن الله",
        "ur": "ان شاء اللہ {pct}% نمازیں وقت پر ادا ہوئیں",
        "fa": "{pct}% از نمازهایم به یاری خدا سر وقت خوانده شد",
        "fr": "{pct}% de mes prières accomplies à l'heure",
        "es": "{pct}% de mis oraciones cumplidas a tiempo",
        "it": "{pct}% delle mie preghiere eseguite puntualmente",
        "hi": "इंशाअल्लाह मेरी {pct}% नमाज़ें समय पर अदा हुईं"
    },
    "weeklyCardStrongest": {
        "en": "Strongest: {prayer}",
        "ar": "أفضل صلاة: {prayer}",
        "ur": "سب سے پابند نماز: {prayer}",
        "fa": "بهترین نماز: {prayer}",
        "fr": "Prière la plus assidue : {prayer}",
        "es": "Oración más constante: {prayer}",
        "it": "Preghiera più costante: {prayer}",
        "hi": "सबसे पाबंद नमाज़: {prayer}"
    },
    "weeklyCardWeakest": {
        "en": "Weakest: {prayer}",
        "ar": "أضعفها: {prayer}",
        "ur": "کمزور ترین: {prayer}",
        "fa": "کمترین پایداری: {prayer}",
        "fr": "Moins assidue : {prayer}",
        "es": "Menos constante: {prayer}",
        "it": "Meno costante: {prayer}",
        "hi": "कमज़ोर पाबंदी: {prayer}"
    },
    "weeklyCardStreak": {
        "en": "🔥 {count}-day streak, all five prayers",
        "ar": "🔥 {count} أيام متتالية بكل الصلوات",
        "ur": "🔥 مسلسل {count} دن تمام نمازیں",
        "fa": "🔥 {count} روز متوالی تمام نمازها",
        "fr": "🔥 {count} jours consécutifs, toutes les prières",
        "es": "🔥 Racha de {count} días, todas las oraciones",
        "it": "🔥 Serie di {count} giorni, tutte le preghiere",
        "hi": "🔥 लगातार {count} दिन, सभी पाँचों नमाज़ें"
    },
    "weeklyCardAppBranding": {
        "en": "Boshra — Adhan, Azkar & Quran",
        "ar": "تطبيق بُشرى — الأذان والأذكار والقرآن",
        "ur": "بشریٰ ایپ — اذان، اذکار اور قرآن",
        "fa": "برنامه بُشریٰ — اذان، اذکار و قرآن",
        "fr": "Boshra — Adhan, Invocations & Coran",
        "es": "Boshra — Adhán, Súplicas y Corán",
        "it": "Boshra — Adhan, Azkar & Corano",
        "hi": "बुशरा ऐप — अज़ान, अज़कार और क़ुरआन"
    },
    "weeklySentencePrayed": {
        "en": "You prayed {total} of {max}",
        "ar": "صليت {total} من {max}",
        "ur": "آپ نے {max} میں سے {total} نمازیں پڑھیں",
        "fa": "شما {total} نماز از {max} نماز را خواندید",
        "fr": "Vous avez accompli {total} prières sur {max}",
        "es": "Has rezado {total} de {max}",
        "it": "Hai pregato {total} su {max}",
        "hi": "आपने {max} में से {total} नमाज़ें पढ़ीं"
    },
    "weeklySentenceStrongest": {
        "en": "strongest: {prayer}",
        "ar": "أفضل صلاة عندك: {prayer}",
        "ur": "آپ کی بہترین نماز: {prayer}",
        "fa": "بهترین نماز شما: {prayer}",
        "fr": "la plus régulière : {prayer}",
        "es": "tu más constante: {prayer}",
        "it": "la più costante: {prayer}",
        "hi": "आपकी सबसे नियमित नमाज़: {prayer}"
    },
    "weeklySentenceWeakest": {
        "en": "weakest: {prayer}",
        "ar": "وأضعفها: {prayer}",
        "ur": "اور سب سے کمزور: {prayer}",
        "fa": "و کمترین: {prayer}",
        "fr": "la moins régulière : {prayer}",
        "es": "y la menos constante: {prayer}",
        "it": "e la meno costante: {prayer}",
        "hi": "और सबसे कमज़ोर: {prayer}"
    },
    "amLabel": {
        "en": "AM",
        "ar": "ص",
        "ur": "صبح",
        "fa": "ق.ظ",
        "fr": "AM",
        "es": "AM",
        "it": "AM",
        "hi": "AM"
    },
    "pmLabel": {
        "en": "PM",
        "ar": "م",
        "ur": "شام",
        "fa": "ب.ظ",
        "fr": "PM",
        "es": "PM",
        "it": "PM",
        "hi": "PM"
    }
}

LANGUAGES = ['en', 'ar', 'ur', 'fa', 'fr', 'es', 'it', 'hi']

def update_arb_files():
    base_dir = os.path.join('lib', 'l10n')
    for lang in LANGUAGES:
        file_path = os.path.join(base_dir, f'app_{lang}.arb')
        if not os.path.exists(file_path):
            print(f"Warning: {file_path} not found!")
            continue
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)

        added = 0
        for key, lang_map in TRANSLATIONS.items():
            val = lang_map.get(lang, lang_map['en'])
            data[key] = val
            added += 1

        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
            f.write('\n')
        print(f"Updated {file_path}: total keys = {len(data)} (+{added})")

if __name__ == '__main__':
    update_arb_files()
