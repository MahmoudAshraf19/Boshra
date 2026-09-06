import json
import os
import asyncio
from google import genai
from google.genai import types

# ====================================================================================
# مفتاح Gemini الخاص بك
# ====================================================================================
GEMINI_API_KEY = os.environ.get("GEMINI_API_KEY", "YOUR_API_KEY")
client = genai.Client(api_key=GEMINI_API_KEY)

# Use the latest available model
MODEL_NAME = 'gemini-2.5-flash'

LANGUAGES = {
    'en': 'English',
    'es': 'Spanish',
    'fr': 'French',
    'it': 'Italian',
    'fa': 'Persian / Farsi',
    'ur': 'Urdu',
    'hi': 'Hindi'
}

SYSTEM_PROMPT = """
You are an expert, professional Islamic translator and scholar.
You will be provided with a JSON array representing a row of Islamic Azkar (Remembrance of Allah) in Arabic.
The array structure is: [Category, Zekr (The actual text/Quran/Hadith), Description/Virtue, Count (Integer), Reference/Source, Search Term].
Your task is to translate all the string fields (indices 0, 1, 2, 4, 5) into the requested target language accurately.
CRITICAL INSTRUCTIONS:
1. Maintain 100% religious accuracy and correct Islamic terminology (e.g., use 'Allah' not 'God', 'Prophet Muhammad', etc.).
2. Do not translate index 3 (the count), keep it as an integer.
3. Return the exact same JSON array structure, just translated.
4. ONLY return a valid JSON array. No explanations, no markdown formatting blocks, just the JSON array.
"""

async def translate_row(row, lang_code, lang_name):
    if not row or len(row) < 6:
        return row
    
    try:
        prompt = f"{SYSTEM_PROMPT.strip()}\n\nTarget Language: {lang_name}\n\nRow to translate:\n{json.dumps(row, ensure_ascii=False)}"
        
        # We run the synchronous Gemini call in a thread to avoid blocking the event loop
        response = await asyncio.to_thread(
            client.models.generate_content,
            model=MODEL_NAME,
            contents=prompt,
            config=types.GenerateContentConfig(temperature=0.3)
        )
        
        result_text = response.text.strip()
        if result_text.startswith("```"):
            result_text = result_text.split("\n", 1)[1]
            if result_text.endswith("```"):
                result_text = result_text.rsplit("\n", 1)[0]
                
        translated_row = json.loads(result_text)
        return translated_row
    
    except Exception as e:
        print(f"Error translating row to {lang_code}: {e}")
        return row

async def process_language(data, lang_code, lang_name):
    print(f"========== Starting translation for {lang_name} ({lang_code}) ==========")
    new_data = {
        "type": data.get("type", "table"),
        "database": data.get("database"),
        "name": data.get("name", "azkar"),
        "withoutRowId": data.get("withoutRowId", False),
        "strict": data.get("strict", False),
        "ddl": data.get("ddl", ""),
        "columns": data.get("columns", []),
        "rows": []
    }
    
    total_rows = len(data['rows'])
    for i, row in enumerate(data['rows']):
        print(f"[{lang_code}] Translating row {i+1}/{total_rows}...")
        translated_row = await translate_row(row, lang_code, lang_name)
        new_data['rows'].append(translated_row)
        
        # Sleep to respect rate limits (Gemini API usually has 15 RPM for free tier, we might need a longer sleep)
        # 4 seconds sleep ensures ~15 requests per minute
        await asyncio.sleep(4.1) 
        
    output_path = f"../assets/data/azkar_{lang_code}.json"
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(new_data, f, ensure_ascii=False, indent=4)
        
    print(f"========== Finished {lang_name}. Saved to {output_path} ==========\n")

async def main():
    input_path = "../assets/data/azkar.json"
    if not os.path.exists(input_path):
        print(f"Error: Could not find {input_path}")
        return
        
    with open(input_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
        
    for lang_code, lang_name in LANGUAGES.items():
        await process_language(data, lang_code, lang_name)
        
    print("ALL TRANSLATIONS COMPLETED SUCCESSFULLY! 🎉")

if __name__ == "__main__":
    asyncio.run(main())
