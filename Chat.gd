extends Panel

const DEFAULT_PORT = 8910

@onready var address:Label = $Address
@onready var host_button = $HostButton
@onready var join_button = $JoinButton
@onready var send_button = $SendButton
@onready var text_log = $TextLog
@onready var text_input = $TextInput




# Called when the node enters the scene tree for the first time.
func _ready():			
	pass # Replace with function body.

func _on_host_pressed():			
	var peer = ENetMultiplayerPeer.new()
	# use set_bind_ip for specific ip instead of default wildcard "*"
	var status = peer.create_server(DEFAULT_PORT) 
	if status != OK:
		print("Something went wrong when creating the server")
		return
	peer.host.compress(ENetConnection.COMPRESS_RANGE_CODER)	
	multiplayer.multiplayer_peer = peer
	host_button.disabled = true
	
func _on_join_pressed():		
	var ip = address.text
	var peer = ENetMultiplayerPeer.new()
	var status = peer.create_client(ip,DEFAULT_PORT)
	if status != OK:
		print("Something went wrong when creating the client")
		return
	peer.host.compress(ENetConnection.COMPRESS_RANGE_CODER)	
	multiplayer.multiplayer_peer = peer
	join_button.disabled = true

func _on_send_pressed():
	var last_line = text_log.get_last_unhidden_line()
	var new_text = text_input.text
	text_log.insert_line_at(last_line,new_text)
	text_input.clear()
