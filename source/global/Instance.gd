extends Node

const Dust = preload("res://source/particles/Dust.tscn")
const Pulse = preload("res://source/particles/Pulse.tscn")
const AfterImage = preload("res://source/particles/AfterImage.tscn")

const Projectile = preload("res://source/projectiles/Projectile.tscn")

const KeyButton = preload("res://source/interface/KeyButton.tscn")

func Dust(): return Dust.instance()
func Pulse(): return Pulse.instance()
func AfterImage(): return AfterImage.instance()

func Projectile(): return Projectile.instance()

func KeyButton(): return KeyButton.instance()