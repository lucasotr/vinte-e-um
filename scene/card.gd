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
var _file_name: String
var value: int

func _init(rank: int, suit: Suit) -> void:
	_rank = rank
	_suit = suit
	value = 10 if rank > 10 else rank
	_file_name = "res://assets/cards/" + get_file_name()
	texture = load(_file_name)
	card_amount += 1
	
func get_file_name() -> String:
	return "card" + get_suit() + get_rank() + ".png"

func get_rank() -> String:
	match _rank:
		1: return "A"
		11: return "J"
		12: return "Q"
		13: return "K"
		_: return str(_rank)

func get_suit() -> String:
	return suit_names[_suit]
