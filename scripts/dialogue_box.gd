extends Control

@onready var dialogue_panel: PanelContainer = $DialoguePanel
@onready var name_label: Label = $DialoguePanel/MarginContainer/VBoxContainer/NameLabel
@onready var hint_label: Label = $DialoguePanel/MarginContainer/VBoxContainer/HintLabel
@onready var dialogue_text: RichTextLabel = $DialoguePanel/MarginContainer/VBoxContainer/DialogueText

var is_open: bool = false
var current_speaker: String = ""
var current_text : String =  ""

func _ready() -> void:
	hide_dialogue()
	
	
func  show_dialogue(speaker_name: String, text: String) -> void:
	current_speaker = speaker_name
	current_text = text
	
	name_label.text = current_speaker
	dialogue_text.text =current_text
	dialogue_panel.show()
	is_open = true
	
	
 
func hide_dialogue () -> void:
	dialogue_panel.hide()
	is_open = false
	current_speaker = ""
	current_text = ""
