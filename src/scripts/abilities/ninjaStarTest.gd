extends Node2D


# Testing code for different ninja star loading

var ninjaStar = load("res://src/weapons/ninja_star.tscn")
@onready var aimPosition = null
@onready var selfPosition = null

var cooldown = 25
var last_shot = 0
var range = 100

