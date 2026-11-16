with open('lib/features/tracker/presentation/widgets/garden_plants.dart', 'r', encoding='utf-8') as f:
    lines = f.readlines()
for i, l in enumerate(lines[:120]):
    if 't(' in l or 'ar ?' in l or any('\u0600' <= c <= '\u06FF' for c in l):
        print(f"L{i+1}: {l.strip()}")
