import os
import json

new_keys_ar = {
  "azkarScreenTitle": "أذكار",
  "azkarScreenSubtitle": "قرب من الله... في كل لحظة",
  "azkarCategoryMorning": "أذكار الصباح",
  "azkarCategoryMorningSub": "أذكار و أذكار الصباح",
  "azkarCategoryEvening": "أذكار المساء",
  "azkarCategoryEveningSub": "أذكار و أذكار المساء",
  "azkarCategoryPrayer": "بعد الصلاة",
  "azkarCategoryPrayerSub": "أذكار بعد الصلاة",
  "azkarCategorySleep": "أذكار النوم",
  "azkarCategorySleepSub": "أذكار قبل النوم",
  "azkarCategoryProtection": "أذكار الحماية",
  "azkarCategoryProtectionSub": "أذكار للحماية والطمأنينة",
  "azkarCategoryDaily": "أذكار يومية",
  "azkarCategoryDailySub": "أذكار متنوعة لليوم",
  "azkarAllCategories": "كل الأقسام"
}

new_keys_en = {
  "azkarScreenTitle": "Azkar",
  "azkarScreenSubtitle": "Close to Allah... in every moment",
  "azkarCategoryMorning": "Morning Azkar",
  "azkarCategoryMorningSub": "Remembrances for the morning",
  "azkarCategoryEvening": "Evening Azkar",
  "azkarCategoryEveningSub": "Remembrances for the evening",
  "azkarCategoryPrayer": "After Prayer",
  "azkarCategoryPrayerSub": "Remembrances after prayer",
  "azkarCategorySleep": "Sleep Azkar",
  "azkarCategorySleepSub": "Remembrances before sleep",
  "azkarCategoryProtection": "Protection Azkar",
  "azkarCategoryProtectionSub": "For protection and tranquility",
  "azkarCategoryDaily": "Daily Azkar",
  "azkarCategoryDailySub": "Various remembrances for the day",
  "azkarAllCategories": "All Categories"
}

l10n_dir = 'd:/Boshra/lib/l10n'

for file_name in os.listdir(l10n_dir):
    if file_name.endswith('.arb'):
        path = os.path.join(l10n_dir, file_name)
        with open(path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        if file_name == 'app_ar.arb':
            data.update(new_keys_ar)
        else:
            data.update(new_keys_en) # Default to EN for others for now to avoid compile errors
            
        with open(path, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
            
print("Added keys successfully.")
