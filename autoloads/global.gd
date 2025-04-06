extends Node

const VOWELS_WITH_DIACTRICS: Dictionary = {
	"a": ["ā", "á", "ǎ", "à"],
	"e": ["ē", "é", "ě", "è"],
	"i": ["ī", "í", "ǐ", "ì"],
	"o": ["ō", "ó", "ǒ", "ò"],
	"u": ["ū", "ú", "ǔ", "ù"],
	"ü": ["ǖ", "ǘ", "ǚ", "ǜ"],
}

const TONE_NEUTRAL_MAP: Dictionary = {
	"ā": "a", "á": "a", "ǎ": "a", "à": "a",
	"ē": "e", "é": "e", "ě": "e", "è": "e",
	"ī": "i", "í": "i", "ǐ": "i", "ì": "i",
	"ō": "o", "ó": "o", "ǒ": "o", "ò": "o",
	"ū": "u", "ú": "u", "ǔ": "u", "ù": "u",
	"ǖ": "ü", "ǘ": "ü", "ǚ": "ü", "ǜ": "ü"
}

const VALID_RIMES: Array = [
	"a", "ai", "ao", "an", "ang",
	"o", "ou", "ong",
	"e", "ei", "en", "eng",
	"i", "in", "ing",
	"u", 
	"ü", "ün",
	"-i", 
	"er", 
	"ia", "iao", "ian", "iang",
	"iê", 
	"io", "iou", "iong",
	"ua", "uai", "uan", "uang",
	"uei", "uen", "ueng",
	"uo", 
	"üan", 
	"üê", 
]

var dict: Dictionary

var valid_neutral_syllables: Array

var settings: Dictionary = {
	"style": 1,
	"range": 6,
}
