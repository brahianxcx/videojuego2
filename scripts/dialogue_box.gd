extends Control

@onready var dialogue_panel: PanelContainer = $DialoguePanel
@onready var name_label: Label = $DialoguePanel/MarginContainer/VBoxContainer/NameLabel
@onready var hint_label: Label = $DialoguePanel/MarginContainer/VBoxContainer/HintLabel
@onready var dialogue_text: RichTextLabel = $DialoguePanel/MarginContainer/VBoxContainer/DialogueText

var is_open: bool = false
var current_speaker: String = ""
var current_text : Array[String] =  []
var current_index: int = 0
func _ready() -> void:
	hide_dialogue()
	
	
func  show_dialogue(speaker_name: String, text: Array[String]) -> void:
	current_speaker = speaker_name
	current_text = text
	current_index = 0 
	name_label.text = current_speaker
	
	if current_text.size() > 0:
		dialogue_text.text =current_text[current_index]
		
	else :
		dialogue_text.text = ""
		
	
	dialogue_panel.show()
	is_open = true
	
	
func next_line() -> void:
	current_index += 1
	
	if current_index >= current_text.size():
		hide_dialogue()
		return
	else:
		dialogue_text.text =current_text[current_index] 
	
func hide_dialogue () -> void:
	dialogue_panel.hide()
	is_open = false
	current_speaker = ""
	current_text = []
	current_index = 0
