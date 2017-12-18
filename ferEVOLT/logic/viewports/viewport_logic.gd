extends Control

export var split_screen_type = 0;

func _ready():
	set_process(true);

func _process(delta):
	update();

func _draw():
	
	var player_viewports = []
	var viewport_count = 0
	
	for child_node in get_parent().get_parent().get_node("racing_scene/starting_positions").get_children():
		if (child_node.has_node("player_scene")):
			var player_viewport = child_node.get_node("player_scene/Viewport")
			player_viewports.append(player_viewport)
			viewport_count += 1
			
	var control_rect = get_rect();
	
	control_rect.pos = Vector2();
	
	split_screen_type = viewport_count % 2
	
	if (viewport_count == 4):
		split_screen_type = 2
	
	if split_screen_type == 0:
		control_rect.size.y /= viewport_count;
	elif split_screen_type == 1:
		control_rect.size.x /= viewport_count;
	elif split_screen_type == 2:
		control_rect.size.x /= 2;
		control_rect.size.y /= 2;
	
	var count = 0
	for viewport in player_viewports:
		viewport.set_rect(control_rect)
		var texture_rect = viewport.get_render_target_texture();
		draw_texture_rect(texture_rect, control_rect, false);
		if split_screen_type == 0:
			control_rect.pos.y += control_rect.size.y;
		elif split_screen_type == 1:
			control_rect.pos.x += control_rect.size.x;
		elif split_screen_type == 2:
			if count == 0:
				control_rect.pos.x += control_rect.size.x;
			elif count == 1:
				control_rect.pos.x -= control_rect.size.x;
				control_rect.pos.y += control_rect.size.y;
			elif count == 2:
				control_rect.pos.x += control_rect.size.x;
				
				
		count+=1