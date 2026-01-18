extends Node2D

enum item { GEM, HEART, HONEY, EMPTY }
@export var type: item = item.EMPTY

signal update_items

func _ready():
# warning-ignore:return_value_discarded
	update_items.connect(Global._on_update_status)
	
	if type == item.GEM:
		$Gem.visible = true
		$Gem.play()
	elif type == item.HEART:
		$Heart.visible = true
		$Heart.play()
	elif type == item.HONEY:
		$Honey.visible = true
		$Honey.play()

func _on_Area2D_body_entered(_body):
	if type == item.GEM:
		Global.gem = Global.gem + 1
		await $Collected.finished
		update_items.emit()
		queue_free()
	elif type == item.HONEY:
		Global.honeycombs = Global.honeycombs + 1
		Global.honeycombs += 1
		await $Collected.finished
		update_items.emit()
		queue_free()
	elif type == item.HEART:
		if Global.health < Global.max_health:
			Global.health = Global.health + 1
			await $Collected.finished
			queue_free()
		else:
			$Full.play()

func _on_Timer_timeout():
	queue_free()
