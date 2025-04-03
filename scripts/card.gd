class_name  Card
extends TextureRect

static var card_amount: int = 0

enum Suit {
	CLUBS,
	DIAMONDS,
	HEARTS,
	SPADES
}

var suit_names = {
	Suit.CLUBS: "Clubs",
	Suit.DIAMONDS: "Diamonds",
	Suit.HEARTS: "Hearts",
	Suit.SPADES: "Spades"
}

var _rank: int
var _suit: Suit
var value: int
var _file_name: String

func _init(rank: int, suit: Suit) -> void:
	_rank = rank
	_suit = suit
	value = 10 if rank > 10 else rank
	_file_name = "res://assets/cards/" + get_file_name()
	texture = load(_file_name)
	card_amount += 1
	
func get_file_name() -> String:
	var rank_string: String = get_rank_string()
	#var suit_string: String = get_suit_string()
	return "card" + suit_names[_suit] + rank_string + ".png"

func get_rank_string() -> String:
	match _rank:
		1: return "A"
		11: return "J"
		12: return "Q"
		13: return "K"
		_: return str(_rank)
