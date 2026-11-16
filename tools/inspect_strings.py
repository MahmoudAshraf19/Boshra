import re
import os

files = [
    'lib/features/sadaqa/presentation/screens/sadaqa_jariya_screen.dart',
    'lib/features/diagnostics/presentation/screens/adhan_diagnostics_screen.dart',
    'lib/features/zakat/presentation/screens/zakat_screen.dart',
    'lib/features/tracker/presentation/screens/prayer_tracker_screen.dart',
    'lib/features/tracker/presentation/screens/prayer_garden_screen.dart',
    'lib/features/tracker/presentation/screens/weekly_summary_screen.dart',
    'lib/features/tracker/presentation/widgets/prayer_garden_card.dart',
    'lib/features/tracker/presentation/widgets/weekly_share_card.dart',
    'lib/features/tracker/presentation/widgets/garden_plants.dart',
    'lib/features/tracker/presentation/widgets/prayer_tree.dart',
]

for fp in files:
    if os.path.exists(fp):
        with open(fp, 'r', encoding='utf-8') as f:
            content = f.read()
        has_t = 'String t(' in content or 't(' in content
        has_l10n = 'AppLocalizations' in content
        print(f"{fp}: has_t={has_t}, has_l10n={has_l10n}")
