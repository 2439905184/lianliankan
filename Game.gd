extends GridContainer
#数据栈
var game_stack = []
func _ready():
	pass

#数据模型
var click_info_model = {'id':0,'x':0,'y':0,'pressed':false,'node':Node2D}
#先判断先后点击的两个按钮的id是否一致
func _on_TextureButton3_pressed():
	var click_info = {}
	click_info['id'] = $TextureButton3.texture_normal.get_rid().get_id()
	#click_info['x'] = $TextureButton3.rect_position.x
	#click_info['y'] = $TextureButton3.rect_position.y
	#click_info['pressed'] = true
	click_info['node'] = $TextureButton3
	if game_stack.size() < 2:
		game_stack.append(click_info)
		print("当前数据栈")
		print(game_stack)
		calc()
	else:
		printerr("超出数据栈大小，不可以入栈！")
	pass
func _on_TextureButton5_pressed():
	var click_info = {}
	click_info['id'] = $TextureButton5.texture_normal.get_rid().get_id()
	#click_info['x'] = $TextureButton5.rect_position.x
	#click_info['y'] = $TextureButton5.rect_position.y
	#click_info['pressed'] = true
	click_info['node'] = $TextureButton5
	if game_stack.size() < 2:
		game_stack.append(click_info)
		print("当前数据栈")
		print(game_stack)
		calc()
	else:
		printerr("超出数据栈大小，不可以入栈！")
	pass
#计算数据栈，每次点击后尝试运算
func calc():
	if game_stack.size() == 2:
		#先做大判断 纹理是否相同
		if game_stack[0]['id'] == game_stack[1]['id']:
			print("纹理相同")
			print("直接删除这两个对象！")
			game_stack[0]['node'].texture_normal = null
			game_stack[1]['node'].texture_normal = null
			game_stack.clear()
			print("清空数据栈！")
			print(game_stack)
			print("清除已连接的信号！")
		else:
			printerr("错误！,纹理不同")
	pass
