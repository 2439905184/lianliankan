extends GridContainer
#数据栈
var game_stack = []
func _ready():
	#$TextureButton.connect("pressed",self,"a")
	pass
func a():
	#print("连接")
	pass
#数据模型
var click_info_model = {'id':0,'x':0,'y':0,'pressed':false,'node':Node2D}
#先判断先后点击的两个按钮的id是否一致
func _on_TextureButton3_pressed():
	var click_info = {}
	if $TextureButton3.texture_normal != null:
		click_info['id'] = $TextureButton3.texture_normal.get_rid().get_id()
		click_info['x'] = $TextureButton3.rect_position.x
		click_info['y'] = $TextureButton3.rect_position.y
	#click_info['pressed'] = true
		click_info['node'] = $TextureButton3
		#连接信号的方法
		click_info['method'] = "_on_TextureButton3_pressed"
	print_debug(click_info.size())
	#判断信号是否存在
	if game_stack.size() < 2 and click_info.size()!=0:
		game_stack.append(click_info)
		print("当前数据栈")
		print(game_stack)
		calc()
	else:
		printerr("超出数据栈大小，不可以入栈！")
		print("当前数据栈")
		print(game_stack)
	pass
func _on_TextureButton4_pressed():
	var click_info = {}
	if $TextureButton4.texture_normal != null:
		click_info['id'] = $TextureButton4.texture_normal.get_rid().get_id()
		click_info['x'] = $TextureButton4.rect_position.x
		click_info['y'] = $TextureButton4.rect_position.y
	#click_info['pressed'] = true
		click_info['node'] = $TextureButton4
		click_info['method'] = "_on_TextureButton4_pressed"
	print_debug(click_info.size())
	if game_stack.size() < 2 and click_info.size()!=0:
		game_stack.append(click_info)
		print("当前数据栈")
		print(game_stack)
		calc()
	else:
		printerr("超出数据栈大小，不可以入栈！")
		print("当前数据栈")
		print(game_stack)
func _on_TextureButton5_pressed():
	var click_info = {}
	if $TextureButton5.texture_normal != null:
		click_info['id'] = $TextureButton5.texture_normal.get_rid().get_id()
		click_info['x'] = $TextureButton5.rect_position.x
		click_info['y'] = $TextureButton5.rect_position.y
	#click_info['pressed'] = true
		click_info['node'] = $TextureButton5
		click_info['method'] = "_on_TextureButton5_pressed"
	print_debug(click_info.size())
	if game_stack.size() < 2 and click_info.size()!=0 :
		game_stack.append(click_info)
		print("当前数据栈")
		print(game_stack)
		calc()
	else:
		printerr("超出数据栈大小，不可以入栈！")
		print("当前数据栈")
		print(game_stack)
	pass
#计算数据栈，每次点击后尝试运算
func calc():
	if game_stack.size() == 2:# and game_stack[0].size()!=0 and game_stack[1].size()!=0:
		#先做大判断 纹理是否相同
		if game_stack[0]['id'] == game_stack[1]['id']:
			print("纹理相同")
			#如果一个按钮被按了两次
			if game_stack[0].hash() == game_stack[1].hash():
				printerr("禁止玩家重复按下相同的按钮")
				printerr("此操作无效")
				print("清栈")
				game_stack.clear()
				print(game_stack)
			#判断是否在同一横列 且假设中间没有阻挡物
			elif game_stack[0]['y'] == game_stack[1]['y']:
				print("直接删除这两个对象！")
				game_stack[0]['node'].texture_normal = null
				game_stack[1]['node'].texture_normal = null
				print("清除已连接的信号！")
				#先判断是否存在信号
				var is_c = game_stack[0]['node'].is_connected("pressed",self,game_stack[0]['method'])
				var is_c2 = game_stack[1]['node'].is_connected("pressed",self,game_stack[1]['method'])
				if is_c and is_c2:
					# disconnect(signal: String, target: Object, method: String)
					#从这个节点上移除信号 应该是self
					game_stack[0]['node'].disconnect("pressed",self,game_stack[0]['method'])
					game_stack[1]['node'].disconnect("pressed",self,game_stack[1]['method'])
					game_stack.clear()
					print("清空数据栈！")
					print(game_stack)
		else:
			printerr("错误！,纹理不同")
			print("清栈，释放栈，玩家可重新操作")
			game_stack.clear()
			print(game_stack)
	pass
	
#var is_c =game_stack[0]['node'].is_connected("pressed",self,game_stack[0]['method'])
#		print(is_c)

