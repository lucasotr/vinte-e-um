class_name Controller extends Node

@onready var model: Model = $"../Model"
@onready var view: View = $"../Views"
@onready var menu: Control = $"../Menu"


#region View Bet
func _ready():
# _ready is place holder, the menu should call show_bet_view() directly
	show_bet_view()

func show_menu():
	menu.show()

func show_bet_view():
	view.view_bet_label_bet.text = "Aposta: " + str(model.bet)
	view.view_bet_label_bank.text = "Banco : " + str(model.bank)
	view.view_bet.show()

func _on_bet_add_button_down() -> void:
	if model.add_bet:
		view.view_bet_add_button.text = "Subtrair"
		model.add_bet = false
	else:
		view.view_bet_add_button.text = "Adicionar"
		model.add_bet = true

func _on_bet_button_down(value: int) -> void:
	model.change_bet(value)

func _on_model_bank_update() -> void:
	view.view_bet_label_bank.text = "Banco: " + str(model.bank)

func _on_model_bet_update() -> void:
	view.view_bet_label_bet.text = "Aposta: " + str(model.bet)

func _on_bet_confirm_button_down() -> void:
	model.confirm_bet()
	view.view_bet.hide()
	show_view_player()

#endregion

#region View Player
func show_view_player():
	view.view_player.show()
	
	view.view_player_player_hand.add_child(model.player_hand[model.draw_card(model.player_hand)])
	view.view_player_player_hand.add_child(model.player_hand[model.draw_card(model.player_hand)])
	model.evaluate_hand()
	view.view_player_dealer_hand.add_child(model.dealer_hand[model.draw_card(model.dealer_hand)])
	# Replace this with back card. Either hide or don't add it.
	view.view_player_dealer_hand.add_child(model.dealer_hand[model.draw_card(model.dealer_hand)])

func _on_model_player_hand_update(index: int):
	view.view_player_player_hand.add_child(model.player_hand[index])
	
func _on_model_score_update() -> void:
	view.view_player_score_label.text = "Pontos: " + str(model.player_hand_score)
	
func _on_model_split_update() -> void:
	view.view_player_split_button.show()


func _on_player_split_button_button_down() -> void:
	
	view.view_player.hide()
	view.view_player_split.show()

func _on_player_hit_button_down() -> void:
	view.view_player_split_button.hide()
	view.view_player_player_hand.add_child(model.player_hand[model.draw_card(model.player_hand)])

func _on_model_hit_update() -> void:
	view.view_player_hit_button.hide()

func _on_player_confirm_button_down() -> void:
	view.view_player_split_button.hide()

#endregion

#region View Player Split
func _on_model_player_hand_split_update(index: int) -> void:
	pass
#endregion

#region View Dealer
func _on_model_dealer_hand_update(index: int) -> void:
	view.view_player_dealer_hand.add_child(model.player_hand[index])
#endregion
