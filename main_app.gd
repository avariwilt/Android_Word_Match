extends Node2D

@onready var word1=$"not sure/Container/VBoxContainer/word1"
@onready var word2=$"not sure/Container/VBoxContainer/word2"
@onready var sentence=$"not sure/Container/sentence/sentence_text"

@onready var word_mode=$"not sure/Container/VBoxContainer"
@onready var sentence_mode=$"not sure/Container/sentence"

@onready var favSentence=preload("res://favourite_sentence.tscn")

var favorites_Sentences=[]
var favorites_WordsMatch=[]

var objects = [
	"lantern", "clock", "violin", "mirror", "umbrella", "mask", "crown", "skull",
	"dagger", "feather", "cage", "rope", "chain", "book", "scroll", "crystal", "chalice",
	"staff", "compass", "key", "door", "window", "bell", "coin", "dice", "candle",
	"armor", "helmet", "wings", "seed", "flower", "vine", "fruit", "shell", "bone",
	"paintbrush", "quill", "paper", "gear", "spring", "bolt", "engine", "potion",
	"hourglass", "jewel", "box", "orb", "telescope", "tower", "sword", "shield",
	"kite", "anchor"
]

var places = [
	"train station", "sewer", "floating city", "desert oasis", "deep forest", "frozen lake",
	"abandoned mall", "subway", "mountain peak", "cliffside ruins", "underwater temple",
	"shipwreck", "castle hall", "cathedral", "observatory", "laboratory", "carnival tent",
	"neon alley", "rooftop", "marketplace", "desert caravan", "empty classroom",
	"dream library", "space station", "asteroid mine", "volcanic cave", "coral reef",
	"sky bridge", "ancient theater", "lighthouse", "cave of mirrors", "cloud island",
	"graveyard", "forgotten garden"
]

var creatures = [
	"dragon", "phoenix", "leviathan", "centaur", "mermaid", "golem", "robot", "ghost",
	"demon", "angel", "griffin", "basilisk", "chimera", "minotaur", "kraken", "faun",
	"vampire", "werewolf", "skeleton", "zombie", "giant", "titan", "alien", "insect swarm",
	"jellyfish", "owl", "crow", "serpent", "fox spirit", "stag", "whale", "monkey", "cat",
	"dog", "wolf", "hare", "moth", "beetle", "snake", "lizard", "fish", "spider", "rat",
	"turtle"
]

var actions = [
	"drifting", "falling", "floating", "breaking", "shattering", "mending", "carrying",
	"hiding", "leaping", "crawling", "melting", "burning", "freezing", "blooming",
	"decaying", "building", "erasing", "dancing", "fighting", "whispering", "screaming",
	"singing", "weaving", "hunting", "feeding", "transforming", "fusing", "splitting",
	"spiraling", "chasing", "waiting", "opening", "closing", "dissolving", "glowing",
	"flickering", "walking", "flying", "riding", "rowing", "swimming", "planting",
	"harvesting"
]

var moods = [
	"eerie", "dreamy", "nostalgic", "frantic", "tragic", "peaceful", "whimsical",
	"lonely", "joyful", "bitter", "chaotic", "mystical", "surreal", "playful",
	"romantic", "melancholic", "solemn", "hopeful", "ominous", "sacred", "cursed",
	"dazzling", "gloomy", "stormy", "vibrant", "faded", "ancient", "futuristic",
	"forgotten", "hidden", "solemn", "quiet", "roaring", "golden", "silver",
	"shadowy", "crystalline", "mechanical", "organic", "rusted", "holy"
]

var words=[objects,places,creatures,actions,moods]


var templates = [
	"A %mood %creature in a %place",
	"A %creature %action in the %place",
	"%creature and %object, both %mood",
	"A %mood %creature holding a %object",
	"A %place where a %creature is %action",
	"A %mood %place filled with %creature"
]

var path1 ="user://favorite_sentence.save"
var path2 ="user://favorite_word_match.save"
func _ready():
	_on_button_1_pressed()
	
	if FileAccess.file_exists(path1) :
		var favourite_file=FileAccess.open(path1,FileAccess.READ)
		favorites_Sentences = favourite_file.get_var()
		favourite_file.close()
	if FileAccess.file_exists(path2) :
		var favourite_file=FileAccess.open(path2,FileAccess.READ)
		favorites_WordsMatch = favourite_file.get_var()
		favourite_file.close()
	
	pass # Replace with function body.


func _on_press_pressed():
	var i=randi_range(0,words.size()-1)
	var word1_type=words[i]
	i=randi_range(0,words.size()-1)
	var word2_type=words[i]
	
	i=randi_range(0,word1_type.size()-1)
	word1.text=word1_type[i]
	
	i=randi_range(0,word2_type.size()-1)
	word2.text=word2_type[i]
	pass # Replace with function body.

## Favourite word
func _on_favorite_pressed():
	print("favorite!")
	favorites_WordsMatch.append(word1.text+" & "+word2.text)
	save_favorites()
	
	pass # Replace with function body.

func _on_favorite_sentence_pressed():
	favorites_Sentences.append(sentence.text)
	save_favorites()
	pass # Replace with function body.


func _on_button_1_pressed():
	word_mode.show()
	sentence_mode.hide()
	$"not sure/Container/favoriteSentenceMode".hide()
	$"not sure/Container/favoriteWordMode".hide()
	pass # Replace with function body.


func _on_button_2_pressed():
	word_mode.hide()
	sentence_mode.show()
	$"not sure/Container/favoriteSentenceMode".hide()
	$"not sure/Container/favoriteWordMode".hide()
	pass # Replace with function body.


func _on_press_sentence_pressed():
	sentence.text=generate_sentence()
	pass # Replace with function body.

func generate_sentence() -> String:
	var template = templates[randi_range(0, templates.size()-1)]
	
	template = template.replace("%object", objects[randi_range(0, objects.size()-1)])
	template = template.replace("%place", places[randi_range(0, places.size()-1)])
	template = template.replace("%creature", creatures[randi_range(0, creatures.size()-1)])
	template = template.replace("%action", actions[randi_range(0, actions.size()-1)])
	template = template.replace("%mood", moods[randi_range(0, moods.size()-1)])
	
	return template



	
@onready var favList=$"not sure/Container/favoriteSentenceMode/VBoxContainer/ScrollContainer/FavSentenceList"
@onready var favList2=$"not sure/Container/favoriteWordMode/VBoxContainer/ScrollContainer/FavWordList"

func _on_button_4_pressed():
	word_mode.hide()
	sentence_mode.hide()
	$"not sure/Container/favoriteSentenceMode".show()
	$"not sure/Container/favoriteWordMode".hide()
	
	for c in favList.get_children():
		c.queue_free()
	
	for fav in favorites_Sentences :
		var favItem=favSentence.instantiate()
		favItem.text=fav
		favList.add_child(favItem)
		
	
	pass # Replace with function body.

func _on_button_3_pressed():
	word_mode.hide()
	sentence_mode.hide()
	$"not sure/Container/favoriteSentenceMode".hide()
	$"not sure/Container/favoriteWordMode".show()
	
	for c in favList2.get_children():
		c.queue_free()
	
	for fav in favorites_WordsMatch :
		var favItem=favSentence.instantiate()
		favItem.text=fav
		favList2.add_child(favItem)
	pass # Replace with function body.


	
func exit_and_save() ->void :
	var fav_file=FileAccess.open(path1,FileAccess.WRITE)
	fav_file.store_var(favorites_Sentences)
	fav_file.close()
	
	fav_file=FileAccess.open(path2,FileAccess.WRITE)
	fav_file.store_var(favorites_WordsMatch)
	fav_file.close()
	
	get_tree().quit()
	pass
	
func save_favorites() -> void:
	var fav_file = FileAccess.open(path1, FileAccess.WRITE)
	fav_file.store_var(favorites_Sentences)
	fav_file.close()

	fav_file = FileAccess.open(path2, FileAccess.WRITE)
	fav_file.store_var(favorites_WordsMatch)
	fav_file.close()

	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		exit_and_save()
