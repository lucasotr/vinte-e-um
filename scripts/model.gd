extends Node

var bank: int
var bet: int

var deck: Array
var dealer_hand: Array
var player_hand: Array

var same_card_rank: bool = false

var player_split: bool = false
var player_hand_split: Array

func load_deck() -> void:
	for suit in range(0, 4):
		for rank in range(1, 14):
			deck.append(Card.new(rank, suit))

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

func draw_card(hand: Array) -> void:
	hand.append(deck.pop_back())

func score_hand(hand: Array) -> int:
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

	return score

func evaluate_hand():
	# This happens in the first turn
	if player_hand[0].get_rank() == player_hand[1].get_rank():
		same_card_rank = true
	else:
		same_card_rank = false

func split_hand():
	player_split = true
	player_hand_split.append(player_hand.pop_back())
	draw_card(player_hand)
	print("Player hand: " + player_hand[0].get_rank() + " " + player_hand[1].get_rank())
	draw_card(player_hand_split)


func play_round() -> void:
	print("================ New Round ================")
	deck.shuffle()
	draw_card(player_hand)
	draw_card(player_hand)
	print("Player hand: " + player_hand[0].get_rank() + " " + player_hand[1].get_rank())
	evaluate_hand()
	if same_card_rank:
		split_hand()
	if player_split:
		print("Player split hand: " + player_hand_split[0].get_rank() + " " + player_hand_split[1].get_rank())
	draw_card(dealer_hand)
	draw_card(dealer_hand)
	print("Dealer hand: " + dealer_hand[0].get_rank() + " " +  dealer_hand[1].get_rank())
	var player_score: int = score_hand(player_hand)
	var dealer_score: int = score_hand(dealer_hand)
	print("Player score: " + str(player_score))
	
	if player_split:
		print("Player split score: " + str(score_hand(player_hand_split)))
	print("Dealer score: " + str(dealer_score))
	
	if dealer_score > player_score :
		print("Dealer won")
	else: 
		print("Player won") 
	
	if player_split:
		if dealer_score > score_hand(player_hand_split):
			print("Dealer won")
		else:
			print("Player split won") 
		
	return_cards()

func _ready() -> void:
	load_deck()
	for i in range(0, 30):
		play_round()
