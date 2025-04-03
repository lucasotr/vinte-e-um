extends Node

var deck: Array

func load_deck():
	var cards: Array
	for suit in range(0, 4):
		for rank in range(1, 14):
			cards.append(Card.new(rank, suit))
	return cards

func _ready() -> void:
	deck = load_deck()
