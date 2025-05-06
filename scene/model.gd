class_name Model extends Node

signal bet_update
signal bank_update
signal score_update
signal split_update
signal hit_update
signal hit_split_update
signal dealer_draw

#region Game Start / Game End
var bank: int = 25
var bet: int = 1
var confirmed_bet: int

var deck: Array
var back_card: TextureRect = TextureRect.new()

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
	back_card.texture = load("res://assets/cards/cardBack0.png")

func return_cards() -> void:
	if dealer_hand:
		for card in dealer_hand:
			card.get_parent().remove_child(card)
		deck.append_array(dealer_hand)
		dealer_hand.clear()

	if player_hand: 
		for card in player_hand:
			card.get_parent().remove_child(card)
		deck.append_array(player_hand)
		player_hand.clear()
	
	if player_hand_split:
		for card in player_hand_split:
			card.get_parent().remove_child(card)
		deck.append_array(player_hand_split)
		player_hand_split.clear()
	
	
	player_split = false
	same_card_rank = false
	deck.shuffle()
	
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
	bank_update.emit()
	bet = 1

#endregion

#region View Player
func draw_card(hand: Array) -> int:
	hand.append(Card.new(8, 0))
	#hand.append(deck.pop_back())
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
		if hand == player_hand:
			hit_update.emit()
		if hand == player_hand_split:
			hit_split_update.emit()
	
	score_update.emit()

func evaluate_hand():
	# This happens in the first turn
	if player_hand[0].get_rank() == player_hand[1].get_rank():
		same_card_rank = true
		if confirmed_bet <= bank:
			split_update.emit()
	else:
		same_card_rank = false


#endregion

#region Split Hand
func split_hand():
	bank -= confirmed_bet
	confirmed_bet *= 2
	player_split = true
	player_hand_split.append(player_hand.pop_back())
#endregion

#region Dealer
func dealer_turn():
	# Dealer buys until 17
	while dealer_hand_score < 17:
		dealer_draw.emit()
		score_hand(dealer_hand)
	
	if dealer_hand_score > 21:
		print("Dealer bust: " + str(dealer_hand_score) + " Hand size: " + str(dealer_hand.size()) )
		for card in dealer_hand:
			print("Card: " +  str(card.value))
	else:
		print("Dealer score: " + str(dealer_hand_score) + " Hand size: " + str(dealer_hand.size()) )
		for card in dealer_hand:
			print("Card: " +  str(card.value))

func dealer_score():
	var player_bust: bool = true if player_hand_score > 21 else false
	var dealer_bust: bool = true if dealer_hand_score > 21 else false
	var dealer_win: bool = true if dealer_hand_score > player_hand_score else false
	
	if player_bust and dealer_bust:
		bank += confirmed_bet
		print("Busters! We have a tie!")
	elif (player_bust == false and dealer_bust == false) and player_hand_score == dealer_hand_score:
		bank += confirmed_bet
		print("Push! We have a tie!")
	elif player_bust == false and dealer_bust == true:
		bank += confirmed_bet * 2
		print("Dealer bust! Player wins")
	elif (player_bust == false and dealer_bust == false) and player_hand_score > dealer_hand_score:
		bank += confirmed_bet * 2
		print("Player wins!")
	elif player_bust == true and dealer_bust == false:
		print("Player bust! Dealer wins")
	elif (player_bust == false and dealer_bust == false) and player_hand_score < dealer_hand_score:
		print("Dealer wins!")
	
	bank_update.emit()
	confirmed_bet = 0
	
	
	
#endregion
