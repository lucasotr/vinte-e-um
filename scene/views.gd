class_name View extends Control

# Maximum card draw is 11, layout should reflect that

#region Menu

@onready var menu: Control = $"../Menu"

func new_game(bet: int, bank: int):
	menu.hide()
	show()
	update_bet_view(bet, bank)
	show_view_bet()
	
#endregion

#region View Bet
@onready var view_bet: Control = $ViewBet
@onready var view_bet_label_bet: Label = $ViewBet/VBoxBetContainer/HBoxBetDisplayContainer/BetLabelBet
@onready var view_bet_label_bank: Label = $ViewBet/VBoxBetContainer/HBoxBetDisplayContainer/BetLabelBank
@onready var view_bet_add_button: Button = $ViewBet/VBoxBetContainer/HBoxBetContainer/BetAddButton
@onready var view_bet_display_container: HBoxContainer = $ViewBet/VBoxBetContainer/HBoxBetDisplayContainer

func show_view_bet():
	view_bet_label_bet.reparent(view_bet_display_container)
	view_bet_display_container.move_child(view_bet_label_bet, 0)
	view_bet.show()

func update_bet_view(bet, bank):
	view_bet_label_bet.text = "Aposta: " + str(bet)
	view_bet_label_bank.text = "Banco : " + str(bank)
	
func update_add_button(add : bool):
	if add:
		view_bet_add_button.text = "Adicionar"
	else:
		view_bet_add_button.text = "Subtrair"
#endregion

#region View Player
@onready var view_player: Control = $ViewPlayer
@onready var view_player_dealer_hand: HBoxContainer = $ViewPlayer/DealerHand
@onready var view_player_displayer: HBoxContainer = $ViewPlayer/PlayerUI/PlayerDisplay
@onready var view_player_score_label: Label = $ViewPlayer/PlayerUI/PlayerDisplay/PlayerLabelScore
@onready var view_player_player_container: HBoxContainer = $ViewPlayer/PlayerUI/HBoxContainer
@onready var view_player_player_hand: HBoxContainer = $ViewPlayer/PlayerUI/HBoxContainer/PlayerHand
@onready var view_player_split_button = $ViewPlayer/PlayerUI/HBoxContainer/PlayerButtons/PlayerSplitButton
@onready var view_player_hit_button = $ViewPlayer/PlayerUI/HBoxContainer/PlayerButtons/PlayerHitButton

func show_view_player():
	view_player_hit_button.show()
	view_player.show()
	
	view_bet_label_bet.reparent(view_player_displayer)
	view_player_displayer.move_child(view_bet_label_bet, 0)

func player_draw_card(card: Card):
	view_player_player_hand.add_child(card)

func dealer_draw_card(card: Card):
	view_player_dealer_hand.add_child(card)

func update_score(score: int, split_1: int, split_2:int):
	view_player_score_label.text = "Pontos: " + str(score)
	view_player_split_score_label_1.text = "Pontos: " + str(split_1)
	view_player_split_score_label_2.text = "Pontos: " + str(split_2)

#endregion

#region View Player Split
@onready var view_player_split: Control = $ViewPlayerSplit
@onready var view_player_split_dealer_hand: HBoxContainer = $ViewPlayerSplit/SplitDealerHand

@onready var view_player_split_hit_button_1: Button = $ViewPlayerSplit/SplitPlayerUI/VBoxContainer/HBoxContainer/SplitHitButton1
@onready var view_player_split_score_label_1: Label = $ViewPlayerSplit/SplitPlayerUI/VBoxContainer/HBoxContainer/SplitScoreLabel1
@onready var view_player_split_hand_1: HBoxContainer = $ViewPlayerSplit/SplitPlayerUI/VBoxContainer/SplitHand1
@onready var view_player_split_container: VBoxContainer = $ViewPlayerSplit/SplitPlayerUI/VBoxContainer2
@onready var view_player_split_hit_button_2: Button = $ViewPlayerSplit/SplitPlayerUI/VBoxContainer2/HBoxContainer/SplitHitButton2
@onready var view_player_split_score_label_2: Label = $ViewPlayerSplit/SplitPlayerUI/VBoxContainer2/HBoxContainer/SplitScoreLabel2
@onready var view_player_split_hand_2: HBoxContainer = $ViewPlayerSplit/SplitPlayerUI/VBoxContainer2/SplitHand2

@onready var view_player_split_bet_label: Label = $ViewPlayerSplit/SplitPlayerUI/VBoxContainer3/SplitBetLabel

func show_view_split():
	view_player_split_button.hide()
	view_player.hide()
	view_player_split_hit_button_2.show()
	view_player_dealer_hand.reparent(view_player_split_dealer_hand)
	view_player_player_hand.reparent(view_player_split_hand_1)

func player_split_draw(card: Card):
	view_player_split_hand_2.add_child(card)

#endregion

#region View Dealer
@onready var view_dealer: Control = $ViewDealer
@onready var view_dealer_dealer_container: HBoxContainer  = $ViewDealer/DealerDealerHand
@onready var view_dealer_timer: Timer = $ViewDealer/Timer
@onready var view_dealer_score_container: VBoxContainer = $ViewDealer/DealerScoreContainer
@onready var view_dealer_player_container: HBoxContainer = $ViewDealer/HBoxContainer
@onready var view_dealer_player_display: VBoxContainer = $ViewDealer/HBoxContainer/DealerBetScoreContainer
@onready var view_dealer_score: Label = $ViewDealer/DealerScoreContainer/DealerDealerScore


func show_view_dealer():
	view_player_score_label.reparent(view_dealer_score_container)
	view_bet_label_bank.reparent(view_dealer_player_display)
	view_bet_label_bet.reparent(view_dealer_player_display)
	view_dealer_player_display.move_child(view_bet_label_bet, 0)
	
	view_player_player_hand.reparent(view_dealer_player_container)
	view_dealer_player_container.move_child(view_player_player_hand, 0)
	view_player_dealer_hand.reparent(view_dealer_dealer_container)
	view_dealer.show()

func show_view_dealer_split(split_score: int):
	view_player_split_hand_2.reparent(view_dealer_player_container)
	view_dealer_player_container.move_child(view_player_split_hand_2, 0)

func view_dealer_restart():
	view_dealer.hide()
	view_player_player_hand.reparent(view_player_player_container)
	view_player_split_hand_2.reparent(view_player_split_container)
	view_player_player_container.move_child(view_player_player_hand, 0)
	view_player_dealer_hand.reparent(view_player)
	view_player.move_child(view_player_dealer_hand, 0)
	
	view_player_score_label.reparent(view_player_displayer)
	view_bet_label_bank.reparent(view_bet_display_container)
#endregion
