#tool
#class_name
extends Node2D
# docstring

################################################################################
## Signals

################################################################################
## Enumerations

enum Heuristics { Entropy, MSV, Scanline }

################################################################################
## Constants

################################################################################
## Exported Variables

################################################################################
## Public Variables

var _overlapping_model_script = load("res://addons/godot_wfc_mono/OverlappingModel.cs")

var overlapping_model

################################################################################
## Private Variables

################################################################################
## Onready Variables

################################################################################
## Virtual Methods

#func _init() -> void:
#	pass # Replace with function body.

# These are the parameters for the ``overlapping_model``'s new() method.
#(_image : ImageTexture, _N : int, _width : int, _height : int, \
#			_periodicInput : bool, _periodic : bool, _symmetry : int, \
#			_ground : int, _heuristic : int)

func _ready() -> void:
	var base_image : Image = load("res://samples/3Bricks.png").get_data()
	overlapping_model = _overlapping_model_script.new(base_image, 3, 48, 48, true, true, 1, 0, Heuristics.Entropy) # 3Bricks.png
	
	randomize()
	var imgtex := ImageTexture.new()
	$Sprite.texture = imgtex
	_do()
	
	return


func _unhandled_key_input(event: InputEventKey) -> void:
	if event.is_action_pressed("ui_accept"):
		_do()
	return

################################################################################
## Public Methods

################################################################################
## Private Methods

func _do():
	var _wfc_image : Image
	for _k in range(10):
		var _seed : int = randi()
		var success : bool = overlapping_model.Run(_seed, -1)
		if success:
			print("DONE")
			_wfc_image = overlapping_model.Graphics()
			break
		else:
			print("CONTRADICTION")
	
	if _wfc_image:
		$Sprite.texture.create_from_image(_wfc_image)
		$Sprite.texture.flags = Texture.FLAG_REPEAT
	return

################################################################################
## Script Classes

#var ind_arr := {}
#
#func p2uid(pattern : Array, number_of_colors_in_image : int) -> int:
#	var result : int = 0
#	var power : int = 1
#	for i in range(pattern.size()):
#		result += pattern[pattern.size() - 1 - i] * power
#		power *= number_of_colors_in_image
#
#	ind_arr[result] = pattern.duplicate()
#	return result


#func uid2p(uid : int, pattern_size : int, number_of_colors_in_image : int) -> Array:
##	var pattern : Array = []
##	for i in range(pattern_size * pattern_size):
##		pattern.append(null)
##	var residue : int = uid
##	var power : int = pow(number_of_colors_in_image, pattern_size * pattern_size)
##
##	for i in range(pattern.size()):
##		power /= number_of_colors_in_image
##		var count : int = 0
##
##		while residue >= power:
##			residue -= power
##			count += 1
##
##		pattern[i] = count
##	return pattern
#	# 512 => 512/2 => 256
#	# 366 - 128 => 238 (residue)
#
##	var pattern : Array = []
##	var power : int = 1
##	for i in range(pattern.size()):
###		result += pattern[pattern.size() - 1 - i] * power
##		power /= number_of_colors_in_image
##
##	return pattern
#	var pattern : Array = []
#	if uid in ind_arr:
#		pattern = ind_arr[uid]
#
#	return pattern
