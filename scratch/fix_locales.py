import json
import os

locales_dir = 'lib/l10n'
en_file = os.path.join(locales_dir, 'app_en.arb')

keys_to_add = [
    "startupLocationDescSaved",
    "@startupLocationDescSaved",
    "startupLocationDescDefault"
]

with open(en_file, 'r', encoding='utf-8') as f:
    en_data = json.load(f)

translations = {k: en_data[k] for k in keys_to_add if k in en_data}

for filename in os.listdir(locales_dir):
    if filename.endswith('.arb') and filename != 'app_en.arb':
        filepath = os.path.join(locales_dir, filename)
        with open(filepath, 'r', encoding='utf-8') as f:
            data = json.load(f)
            
        added = False
        
        # Remove old key
        if "startupLocationDesc" in data:
            del data["startupLocationDesc"]
            added = True
            
        for k, v in translations.items():
            if k not in data:
                data[k] = v
                added = True
                
        if added:
            with open(filepath, 'w', encoding='utf-8') as f:
                json.dump(data, f, ensure_ascii=False, indent=2)
            print(f"Updated {filename}")
        else:
            print(f"Skipped {filename} (already up to date)")
