extends Control
@onready var item_list: ItemList = $InventoryPanel/MarginContainer/VBoxContainer/ItemList

var is_open: bool = false

func _ready() -> void:
	hide_inventory()
	InventoryManager.inventory_updated.connect(refresh_inventory)
func  show_inventory () -> void:
	refresh_inventory()
	show()
	is_open = true
	



func hide_inventory() -> void:
	hide()
	is_open = false
	
	
func toggle_inventory () -> void:
	if is_open:
		hide_inventory()
	else:
		show_inventory()
	
func refresh_inventory() -> void:
	item_list.clear()
	
	var items = InventoryManager.get_items()
	
	for item in items:
		var line = item ["name"] + "x" + str(item["quantity"])
		item_list.add_item(line)
