class_name View extends Control

# Maximum card draw is 11, layout should reflect that





#region View Bet
@onready var view_bet: Control = $ViewBet
@onready var view_bet_label_bet: Label = $ViewBet/VBoxBetContainer/HBoxBetDisplayContainer/BetLabelBet
@onready var view_bet_label_bank: Label = $ViewBet/VBoxBetContainer/HBoxBetDisplayContainer/BetLabelBank
@onready var view_bet_add_button: Button = $ViewBet/VBoxBetContainer/HBoxBetContainer/BetAddButton
#endregion

#region View Player
@onready var view_player: Control = $ViewPlayer
@onready var view_player_dealer_hand: Control = $ViewPlayer/DealerHand
@onready var view_player_bet_label: Control = $ViewPlayer/PlayerUI/PlayerDisplay/PlayerLabelBet
@onready var view_player_score_label: Label = $ViewPlayer/PlayerUI/PlayerDisplay/PlayerLabelScore
@onready var view_player_player_hand: Control = $ViewPlayer/PlayerUI/HBoxContainer/PlayerHand
@onready var view_player_split_button = $ViewPlayer/PlayerUI/HBoxContainer/PlayerButtons/PlayerSplitButton
@onready var view_player_hit_button = $ViewPlayer/PlayerUI/HBoxContainer/PlayerButtons/PlayerHitButton
#endregion

#region View Player Split
@onready var view_player_split: Control = $ViewPlayerSplit
@onready var view_player_split_dealer_hand: HBoxContainer = $ViewDealer/DealerDealerHand
@onready var view_player_split_hand_1: HBoxContainer = $ViewPlayerSplit/SplitPlayerUI/VBoxContainer/SplitHand1
@onready var view_player_split_score_label_1: Label = $ViewPlayerSplit/SplitPlayerUI/VBoxContainer/HBoxContainer/SplitScoreLabel1
@onready var view_player_split_hand_2: HBoxContainer = $ViewPlayerSplit/SplitPlayerUI/VBoxContainer2/SplitHand2
@onready var view_player_split_score_label_2: Label = $ViewPlayerSplit/SplitPlayerUI/VBoxContainer2/HBoxContainer/SplitScoreLabel2
@onready var view_player_split_bet_label: Label = $ViewPlayerSplit/SplitPlayerUI/VBoxContainer3/SplitBetLabel

#endregion

#region View Dealer
@onready var view_dealer: Control = $ViewDealer
#endregion
