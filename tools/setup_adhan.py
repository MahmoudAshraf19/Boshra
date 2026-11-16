import os
import shutil

src = "assets/audio/azan_normal"
raw = "android/app/src/main/res/raw"
ios = "ios/Runner/adhan_sounds"

os.makedirs(raw, exist_ok=True)
os.makedirs(ios, exist_ok=True)

files_map = {
    "mohammed_refat": "mohammed_refat.mp3",
    "abdul_basit": "abdul-basit_abdul-samad.mp3",
    "al_hussary": "al_hussary.mp3",
    "ali_mulla": "ali_ahmed_mulla.mp3",
    "minshawi": "El-Minshawi.mp3",
    "essam_bukhari": "essam-bukhari.MP3",
    "naji_qazzaz": "naji-qazzaz.mp3",
    "naqshabandy": "naqshabandy.mp3",
    "nayef_fida": "nayef_fida.mp3"
}

for reciter_id, filename in files_map.items():
    f = os.path.join(src, filename)
    if not os.path.isfile(f):
        print(f"MISSING: {f}")
        continue
    raw_dest = os.path.join(raw, f"azan_{reciter_id}.mp3")
    ios_dest = os.path.join(ios, f"azan_{reciter_id}.mp3")
    shutil.copy2(f, raw_dest)
    shutil.copy2(f, ios_dest)
    print(f"ok  {reciter_id} -> {raw_dest}")

print("Adhan setup completed successfully for Android and iOS.")

