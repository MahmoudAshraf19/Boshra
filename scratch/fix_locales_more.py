import json
import os

locales_dir = 'lib/l10n'
en_file = os.path.join(locales_dir, 'app_en.arb')

keys_to_add = [
    "moreScreenTitle",
    "generalSettings",
    "appearance",
    "systemDefault",
    "appLanguage",
    "alertsSettings",
    "notifications",
    "adhanAndReminders",
    "dataAndStorage",
    "storage",
    "storageDesc",
    "infoAndSupport",
    "privacyAndPermissions",
    "aboutBoshra"
]

with open(en_file, 'r', encoding='utf-8') as f:
    en_data = json.load(f)

for filename in os.listdir(locales_dir):
    if filename.endswith('.arb') and filename != 'app_en.arb' and filename != 'app_ar.arb':
        filepath = os.path.join(locales_dir, filename)
        with open(filepath, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        modified = False
        for key in keys_to_add:
            if key not in data and key in en_data:
                data[key] = en_data[key]
                modified = True
                
        if modified:
            with open(filepath, 'w', encoding='utf-8') as f:
                json.dump(data, f, ensure_ascii=False, indent=2)
            print(f"Updated {filename}")
