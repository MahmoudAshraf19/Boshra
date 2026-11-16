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
    print(f"\n==================== {fp} ====================")
    with open(fp, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    for idx, line in enumerate(lines):
        if 't(' in line or any('\u0600' <= c <= '\u06FF' for c in line):
            print(f"L{idx+1}: {line.strip()}")
