extends Node

const Dust = preload("res://source/particles/Dust.tscn")
const Pulse = preload("res://source/particles/Pulse.tscn")
const Projectile = preload("res://source/projectiles/Projectile.tscn")

func Dust(): return Dust.instance()
func Pulse(): return Pulse.instance()
func Projectile(): return Projectile.instance()