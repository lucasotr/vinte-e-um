class_name Controller extends Node

@onready var model: Model = $"../Model"
@onready var view: View = $"../Views"
@onready var menu: Control = $"../Menu"

#region Menu

func _on_new_game_button_down() -> void:
	view.menu.hide()
	view.show()
	show_bet_view()
#endregion

#region View Bet
func show_menu():
	view.menu.show()

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
	view.view_dealer_bank.text =  "Banco: " + str(model.bank)

func _on_model_bet_update() -> void:
	view.view_bet_label_bet.text = "Aposta: " + str(model.bet)

func _on_bet_confirm_button_down() -> void:
	model.confirm_bet()
	view.view_bet.hide()
	show_view_player()

#endregion

#region View Player
func show_view_player():
	view.view_player_hit_button.show()
	view.view_player.show()
	view.view_player_bet_label.text = "Aposta: " + str(model.confirmed_bet)
	view.view_player_player_hand.add_child(model.player_hand[model.draw_card(model.player_hand)])
	view.view_player_player_hand.add_child(model.player_hand[model.draw_card(model.player_hand)])
	model.evaluate_hand()
	_on_model_dealer_draw()
	# Replace this with back card. Add place holder back card and draw the second one on dealer turn.
	view.view_player_dealer_hand.add_child(model.back_card)

func _on_model_dealer_draw() -> void:
	view.view_player_dealer_hand.add_child(model.dealer_hand[model.draw_card(model.dealer_hand)])

func _on_model_score_update() -> void:
	view.view_player_score_label.text = "Pontos: " + str(model.player_hand_score)
	view.view_player_split_score_label_1.text = "Pontos: " + str(model.player_hand_score)
	view.view_player_split_score_label_2.text = "Pontos: " + str(model.player_hand_split_score)
	
func _on_model_split_update() -> void:
	view.view_player_split_button.show()

func _on_player_hit_button_down() -> void:
	view.view_player_split_button.hide()
	view.view_player_player_hand.add_child(model.player_hand[model.draw_card(model.player_hand)])
	# model.player_hand[ model.draw(player_hand) ] returns the index of the drawn card.
	
func _on_model_hit_update() -> void:
	view.view_player_hit_button.hide()
	view.view_player_split_hit_button_1.hide()

func _on_player_confirm_button_down() -> void:
	view.view_player_split_button.hide()
	view.view_player.hide()
	dealer_turn()

#endregion

#region View Player Split

func _on_player_split_button_button_down() -> void:
	view.view_player_split_button.hide()
	view.view_player.hide()
	
	# Move dealer hand to view.view_player_split_dealer_hand
	view.view_player_dealer_hand.reparent(view.view_player_split_dealer_hand)
	
	model.split_hand()
	
	# Move player hand to view.view_player_split_hand_1
	view.view_player_player_hand.reparent(view.view_player_split_hand_1)
	
	# Remove second card from player hand
	model.player_hand_split[0].reparent(view.view_player_split_hand_2)
	
	# Draw card player hand
	view.view_player_player_hand.add_child(model.player_hand[model.draw_card(model.player_hand)])
	
	# Draw card split hand
	view.view_player_split_hand_2.add_child(model.player_hand_split[model.draw_card(model.player_hand_split)])
	
	
	view.view_player_split_bet_label.text = str("Aposta: " + str(model.confirmed_bet))
	
	view.view_player_split_hit_button_1.show()
	view.view_player_split.show()
	

# Botão Comprar
func _on_split_hit_button_1_button_down() -> void:
	view.view_player_split_hand_1.add_child(model.player_hand[model.draw_card(model.player_hand)])
	# Calls a function in the model that emits a signal to update the view

func _on_split_hit_button_2_button_down() -> void:
	view.view_player_split_hand_2.add_child(model.player_hand_split[model.draw_card(model.player_hand_split)])
	# Calls a function in the model that emits a signal to update the view

func _on_model_hit_split_update() -> void:
	view.view_player_split_hit_button_2.hide()

# Botão confirmar
func _on_split_confirm_button_button_down() -> void:
	view.view_player_split.hide()
	dealer_turn()
#endregion

#region View Dealer
func dealer_turn():
	view.view_player_player_hand.reparent(view.view_dealer_player_container)
	view.view_dealer_player_container.move_child(view.view_player_player_hand, 0)
	view.view_player_dealer_hand.reparent(view.view_dealer_dealer_container)
	
	view.view_dealer_bet.text = "Aposta: " + str(model.confirmed_bet)
	view.view_dealer_bank.text = "Banco: " + str(model.bank)
	
	if model.player_split:
		view.view_dealer_player_split_score.text = "Pontos mão 2 do Jogador: " + str(model.player_hand_split_score)
		view.view_dealer_player_split_score.show()
		view.view_player_split_hand_2.reparent(view.view_dealer_player_container)
		view.view_dealer_player_container.move_child(view.view_player_split_hand_2, 1)
	else:
		view.view_dealer_player_split_score.hide()
	
	view.view_dealer.show()
	
	view.view_dealer_player_score.text = "Pontos mão 1 do Jogador: " + str(model.player_hand_score)
	view.view_player_dealer_hand.remove_child(model.back_card)
	model.dealer_turn()
	view.view_dealer_score.text = "Pontos dealer: " + str(model.dealer_hand_score)
	
	if model.player_split: 
		model.dealer_score(model.player_hand_split_score)
	model.dealer_score(model.player_hand_score)
	
	view.view_dealer_timer.start()

	
func _on_timer_timeout() -> void:
	model.return_cards()
	view.view_player_split_hand_2.reparent(view.view_player_split_container)
	view.view_player_player_hand.reparent(view.view_player_player_container)
	view.view_player_player_container.move_child(view.view_player_player_hand, 0)
	view.view_player_dealer_hand.reparent(view.view_player)
	view.view_player.move_child(view.view_player_dealer_hand, 0)
	view.view_dealer.hide()
	show_bet_view()	
#endregion
