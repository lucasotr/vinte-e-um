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
	# Replace this with back card. Add place holder back card and draw the second one on dealer turn.
	view.view_player_dealer_hand.add_child(model.dealer_hand[model.draw_card(model.dealer_hand)])

func _on_model_score_update() -> void:
	view.view_player_score_label.text = "Pontos: " + str(model.player_hand_score)
	
func _on_model_split_update() -> void:
	view.view_player_split_button.show()

func _on_player_split_button_button_down() -> void:
	view.view_player_split_button.hide()
	# This will probably have to be refactored for the back card
	view.view_player_dealer_hand.remove_child(model.dealer_hand[0])
	view.view_player_dealer_hand.remove_child(model.dealer_hand[1])
	
	view.view_player_player_hand.remove_child(model.player_hand[0])
	view.view_player_player_hand.remove_child(model.player_hand[1])
	view.view_player.hide()
	model.split_hand()
	view.view_player_split.show()
	# This will probably have to be refactor for the back card
	view.view_player_split_dealer_hand.add_child(model.dealer_hand[0])
	view.view_player_split_dealer_hand.add_child(model.dealer_hand[1])
	view.view_player_split_hand_1.add_child(model.player_hand[0])
	view.view_player_split_hand_2.add_child(model.player_hand_split[0])
	view.view_player_split_hand_1.add_child(model.player_hand[model.draw_card(model.player_hand)])
	view.view_player_split_hand_1.add_child(model.player_hand_split[model.draw_card(model.player_hand_split)])
	

func _on_player_hit_button_down() -> void:
	view.view_player_split_button.hide()
	view.view_player_player_hand.add_child(model.player_hand[model.draw_card(model.player_hand)])
	# model.player_hand[ model.draw(player_hand) ] returns the index of the drawn card.
	
func _on_model_hit_update() -> void:
	view.view_player_hit_button.hide()

func _on_player_confirm_button_down() -> void:
	view.view_player_split_button.hide()
	view.view_player.hide()
	view.view_dealer.show()

#endregion

#region View Player Split

# Botão Comprar
func _on_split_hit_button_1_button_down() -> void:
	pass # Replace with function body.

func _on_split_hit_button_2_button_down() -> void:
	pass # Replace with function body.
	
# Botão confirmar
func _on_split_confirm_button_button_down() -> void:
	pass # Replace with function body.
#endregion

#region View Dealer

#endregion
