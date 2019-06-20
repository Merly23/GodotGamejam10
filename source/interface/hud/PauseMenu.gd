extends KeyboardMenu

const fade_time = 0.5

var active = false

onready var tween := $Tween as Tween

onready var menu := $Layer2/PopupPanel
onready var background := $Layer1/TextureRect

onready var origin_position = menu.rect_global_position
onready var offscreen_position = menu.rect_global_position + Vector2(0, -400)

func _input(event: InputEvent) -> void:

	if event.is_action_pressed("ui_cancel") and not tween.is_active():
		toggle()

	if not active:
		return

	if event.is_action_pressed("ui_down"):
		next_button()
	elif event.is_action_pressed("ui_up"):
		previous_button()
	elif event.is_action_pressed("ui_accept"):
		current_button.set("custom_styles/normal", style_pressed)
		current_button.emit_signal("pressed")

func _ready() -> void:
	menu.rect_global_position = offscreen_position
	background.hide()

func _register_buttons() -> void:
	register_button($Layer2/PopupPanel/CenterContainer/VBoxContainer/Resume)
	register_button($Layer2/PopupPanel/CenterContainer/VBoxContainer/Quit)

func toggle() -> void:
	if background.visible:
		fade_out()
	else:
		fade_in()

func fade_in() -> void:
	get_tree().paused = true
	_set_current_button_index(0, true)
	tween.stop_all()
	tween.remove_all()

	background.modulate = Color("00FFFFFF")
	background.show()

	tween.interpolate_property(background, "modulate", Color("00FFFFFF"), Color("FFFFFFFF"), fade_time / 2, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.interpolate_property(menu, "rect_global_position", menu.rect_global_position, origin_position, fade_time, Tween.TRANS_BACK, Tween.EASE_OUT)
	tween.start()

	active = true

	Audio.play_sfx("menu_open")
	Glitch.level = 1
	if Global.Player: Global.Player.cancel_slow_motion()

func fade_out() -> void:
	tween.stop_all()
	tween.remove_all()

	tween.interpolate_property(background, "modulate", Color("FFFFFFFF"), Color("00FFFFFF"), fade_time / 2, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.interpolate_property(menu, "rect_global_position", menu.rect_global_position, offscreen_position, fade_time, Tween.TRANS_BACK, Tween.EASE_IN)
	tween.start()

	active = false

	Glitch.level = 0
	Audio.play_sfx("menu_close")

func _on_Tween_tween_all_completed() -> void:
	if background.modulate == Color("00FFFFFF"):
		get_tree().paused = false
		background.hide()


func _on_Resume_pressed() -> void:
	fade_out()

func _on_Quit_pressed() -> void:
	get_tree().paused = false
	Scene.change(Scene.TitleScreen)
