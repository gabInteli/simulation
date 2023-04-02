extends Spatial

#declarações de variáveis utilizadas
var label_x
var label_y
var label_z
var ponta 
var tween
var new_position
export var URL = "http://10.254.18.127:3000/godot" 

func _on_Request_pressed():
	$Timer.start()
	$HTTPRequest.request(URL)
	$CanvasLayer/Request.visible = false
	$CanvasLayer/Stop.visible = true

func _on_Stop_pressed():
	$Timer.stop()
	$CanvasLayer/Stop.visible = false
	$CanvasLayer/Request.visible = true

func _ready():
	$CanvasLayer/Stop.visible = false
	ponta = get_node("RigidBody")
	$Timer.wait_time = 5
	label_x = get_node("Label_x")
	label_y = get_node("Label_y")
	label_z = get_node("Label_z")

func _on_Timer_timeout():
	_on_Request_pressed()
	
func animate_to_position(position):
	tween = $Tween
	tween.interpolate_property(
		ponta, "translation", ponta.translation, position, 1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT
	)
	tween.start()

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var output = body.get_string_from_utf8()
	var x = output.get_slice("/",0)
	var y = output.get_slice("/",1)
	var z = output.get_slice("/",2)
	new_position = Vector3(x,y,z) 
	animate_to_position(new_position)
	
	label_x.text = "Valor de x: " + String(x)
	label_y.text = "Valor de y: " + String(y)
	label_z.text = "Valor de z: " + String(z)
	$HTTPRequest.cancel_request()
