import os

tone_marks = {
    "a": ["ā", "á", "ǎ", "à"],
    "e": ["ē", "é", "ě", "è"],
    "i": ["ī", "í", "ǐ", "ì"],
    "o": ["ō", "ó", "ǒ", "ò"],
    "u": ["ū", "ú", "ǔ", "ù"],
    "ü": ["ǖ", "ǘ", "ǚ", "ǜ"],  # For ü (ü is often written as 'v' in input systems)
}

def divide(syllable):
    vowels = ""
    for char in syllable:
        if char in "aeiouü":
            vowels += char
        elif vowels:
            break
    parts = syllable.split(vowels, 1)
    return [parts[0], vowels, parts[1] if len(parts) > 1 else ""]

def apply_tone(syllable, tone):
    if tone == 0:
        return syllable  # No tone modification
    
    _, vowels, _ = divide(syllable)
    if not vowels:
        return syllable
    
    if len(vowels) == 1:
        return syllable.replace(vowels, tone_marks[vowels][tone - 1])
    
    for target in "aeo":  # Prioritize a, then e, then o
        if target in vowels:
            return syllable.replace(target, tone_marks[target][tone - 1])
    
    return syllable.replace(vowels[-1], tone_marks[vowels[-1]][tone - 1])

def convert_pinyin(filename):
    base, ext = os.path.splitext(filename)
    if ext.lower() != ".wav":
        return None  # Only process .wav files
    
    if not base[-1].isdigit():
        return None  # Skip if it doesn't end with a number
    
    tone = int(base[-1])
    if tone < 1 or tone > 4:
        return None  # Only process tones 1-4
    
    pinyin_base = base[:-1]  # Remove tone number
    converted = apply_tone(pinyin_base, tone)
    new_name = converted + ".wav"
    
    return new_name

def rename_wav_files():
    for filename in os.listdir():
        new_name = convert_pinyin(filename)
        if new_name and filename != new_name:
            os.rename(filename, new_name)
            print(f"Renamed: {filename} -> {new_name}")

if __name__ == "__main__":
    rename_wav_files()