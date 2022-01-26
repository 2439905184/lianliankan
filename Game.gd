extends GridContainer
#数据栈
var game_stack = []
#未使用的变量
var canvas_rid
func _ready():
	#绘制测试 0拐直线
	#draw_path(Vector2(0,0),Vector2(0,-40),0)
	#绘制完成需要清栈并清屏 这里需要延迟执行 update重绘
	#$Timer.start()
	pass


func _on_TextureButton2_pressed():
	var click_info = {}
	if $TextureButton2.texture_normal != null:
		click_info['id'] = $TextureButton2.texture_normal.get_rid().get_id()
		click_info['x'] = $TextureButton2.rect_position.x
		click_info['y'] = $TextureButton2.rect_position.y
	#click_info['pressed'] = true
		click_info['node'] = $TextureButton2
		#连接信号的方法
		click_info['method'] = "_on_TextureButton2_pressed"
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
	pass # Replace with function body.
#数据模型
#var click_info_model = {'id':0,'x':0,'y':0,'pressed':false,'node':Node2D}
#先判断先后点击的两个按钮的id是否一致
#下面的方法待重构
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
			#此处代码需要继续升级 检测中间是否存在障碍物
			elif game_stack[0]['y'] == game_stack[1]['y']:
				print("直接删除这两个对象！")
				game_stack[0]['node'].texture_normal = null
				game_stack[1]['node'].texture_normal = null
				print("绘制连接线!")
				var p1 = game_stack[0]['node'].rect_position + Vector2(32,32)
				var p2 = game_stack[1]['node'].rect_position + Vector2(32,32)
				draw_path(p1,p2,0)
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
#接线，转折宽度 而不是线宽
var line_height = 20
var line_width = 100
#线宽
var line_storke = 5.0
#绘制A到B的路径 计算路径 拐角个数
#接线栈
var draw_stack = []
func draw_path(posA:Vector2,posB:Vector2,corner:int):
	var each_data ={}
	#接线栈数据模型
	var each_data_model = {'from':Vector2(),'to':Vector2()}
	if corner == 0:
		each_data['from'] = posA
		each_data['to'] = posB
		draw_stack.append(each_data)
		pass
	if corner == 1:
		pass
	if corner == 2:
		pass
	print("接线栈数据")
	print(draw_stack)
	update()
	$clear_timer.start()
	pass
#未使用变量 需要清理
var to = Vector2(0,-40)
var to_x = 0
var to_y = 0

func _process(delta):
	#update()
	pass
enum draw_action{up,down,left,right}
var action 
func _draw():
	if draw_stack.size() == 1:
		draw_line(draw_stack[0]['from'],draw_stack[0]['to'],Color.red,line_storke)
#	#假设转折为2 则需要画3段直线 
#	to_y = -line_height
#	draw_line(Vector2(0,0),Vector2(0,to_y),Color.red,5.0)
#	to_x = line_width 
#	draw_line(Vector2(0,to_y),Vector2(to_x,to_y),Color.red,5.0)
#	to_y = 0
#	draw_line(Vector2(to_x,-line_height),Vector2(100,0),Color.red,5.0)
	#print(to_x,to_y)
	pass
#清栈计时器
func _on_Timer_timeout():
	print("清空接线栈！")
	draw_stack.clear()
	print(draw_stack)
	update()
	#再次绘制行为 #不能这样写，会永久循环
#	draw_path(Vector2(0,0),Vector2(100,-40),0)
#	$Timer.start()
	pass 
