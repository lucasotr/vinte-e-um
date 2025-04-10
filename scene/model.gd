class_name Model extends Node

signal bet_update
signal bank_update
signal score_update
signal split_update
signal hit_update


#region Game Start / Game End
var bank: int = 25
var bet: int = 1
var confirmed_bet: int

var deck: Array

var same_card_rank: bool = false
var player_split: bool = false

var dealer_hand: Array
var player_hand: Array
var player_hand_split: Array
var dealer_hand_score: int
var player_hand_score: int
var player_hand_split_score: int


func load_deck() -> void:
	for suit in range(0, 4):
		for rank in range(1, 14):
			deck.append(Card.new(rank, suit))
	deck.shuffle()

func _ready():
	load_deck()

func return_cards() -> void:
	if dealer_hand:
		deck.append_array(dealer_hand)
		dealer_hand.clear()
	if player_hand: 
		deck.append_array(player_hand)
		player_hand.clear()
	if player_hand_split:
		deck.append_array(player_hand_split)
		player_hand_split.clear()
	player_split = false
	same_card_rank = false
#endregion

#region Bet View
var add_bet: bool = true

func change_bet(value: int):
	if add_bet:
		bet += value
	else:
		bet -= value
	bet = clamp(bet, 1, bank)
	bet_update.emit()

func confirm_bet():
	confirmed_bet = bet
	bank = bank - bet
	print(str(confirmed_bet) + " " + str(bank))
	bank_update.emit()
	bet = 1

#endregion

#region View Player
func draw_card(hand: Array) -> int:
	#hand.append(Card.new(1,0))
	hand.append(deck.pop_back())
	score_hand(hand)
	return hand.size() - 1

func score_hand(hand: Array):
	var score: int
	var aces_count: int

	for card in hand:
		if card.value == 1:
			aces_count += 1
		else:
			score += card.value
	score += aces_count
	
	while aces_count > 0 and score + 10 <= 21:
		score += 10
		aces_count -= 1

	if hand == player_hand:
		player_hand_score = score
	elif hand == player_hand_split:
		player_hand_split_score = score
	else:
		dealer_hand_score = score
	
	if score > 20:
		hit_update.emit()
	
	score_update.emit()

func evaluate_hand():
	# This happens in the first turn
	if player_hand[0].get_rank() == player_hand[1].get_rank():
		same_card_rank = true
		split_update.emit()
	else:
		same_card_rank = false


#endregion

#region Split Hand
func split_hand():
	player_split = true
	player_hand_split.append(player_hand.pop_back())
#endregion
