extends Node

var items: Array[Dictionary] = []

func add_item(item_id: String, item_name: String, amount: int = 1) -> void:
	 
	for item in items:
		if item["id"]== item_id:
			item["quantity"]+= amount
		return
	
	
	
	
	items.append({
		"id": item_id,
		"name": item_name,
		"quianty": amount
	})
	
func remove_items(item_id: String, amount: int=1) -> void:
	for i in range(items.size()):
		if items[i]["id"] == item_id:
			items[i]["quantity"] -= amount
			
			if items[i]["quantity"] <= 0:
				items.remove_at(i)
			return
			
func has_item(item_id: String) -> bool:
	for item in items:
		if item["id"]== item_id:
			return true
	return false
	
func get_item_quantity(item_id: String) -> int:
	for item  in items:
		if item["id"] == item_id:
			return item["quantity"]
			
	return 0
	
func get_items() -> Array[Dictionary]:
	return items
