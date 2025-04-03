extends GutTest

var Controller:PackedScene = load("res://scenes/control.tscn")
var _controller

func before_each():
	_controller = autofree(Controller.instantiate())

func after_each():
	autoqfree(_controller)

func test_take_damage():
	_controller.hp = 100
	var result = _controller.take_damage(10)
	assert_eq(_controller.hp, 90, "HP should be 90")

func test_take_damage_not_below_zero():
	_controller.hp = 5
	_controller.take_damage(10)
	assert_true(_controller.hp >= 0, "HP should be 0 or higher")

func test_take_damage_with_shield():
	_controller.hp = 100
	_controller.shield = true
	_controller.take_damage(10)
	assert_true(_controller.hp > 90, "HP should be higher than 90")
	
