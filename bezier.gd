extends Node2D

var step = 30

var green_color 	:= "#15cb92"
var filler_color	:= "#9e0059"
var quad_color  	:= "#ff570a"
var white_color 	:= "#F7F7FF"

var should_draw_bezier				: bool = true
var should_draw_quadratic			: bool = false
var should_draw_quadratic_fillers	: bool = true
var should_draw_cricle				: bool = true

var bezier_width	 		: float = 3.0
var circle_radius			: float = 14.0
var quadratic_filler_width	: float = 1.0
var quadratic_width			: float = 2.0
var shadow_size				: float = 4.0



var points := []
var cubic_points := []
var quadratic_points := []

func bezier(p0:Vector2, p1:Vector2, p2:Vector2, p3:Vector2) -> void:
	points.clear()
	cubic_points.clear()
	quadratic_points.clear()
	
	var t := 0.0
	
	for _i in range(0, step+1):
		var p = cubic(p0,p1,p2,p3,t)
		points.append(p)
		t += 1.0/step
	
	update()


func cubic(p0, p1, p2, p3, t) -> Vector2:
	var v0 = quadratic(p0, p1, p2, t)
	var v1 = quadratic(p1, p2, p3, t)
	cubic_points.append(v0)
	cubic_points.append(v1)
	return lerp(v0, v1, t)


func quadratic(p0, p1, p2, t) -> Vector2:
	var v0 = linear(p0, p1, t)
	var v1 = linear(p1, p2, t)
	quadratic_points.append(v0)
	quadratic_points.append(v1)
	return lerp(v0, v1, t)


func linear(p0, p1, t) -> Vector2:
	return lerp(p0, p1, t)




func _draw():
	if should_draw_bezier:
		draw_bezier()
	if should_draw_quadratic_fillers:
		draw_quadratic_fillers()
	if should_draw_quadratic:
		draw_quadratic()
	if should_draw_cricle:
		draw_green_circles()


func draw_quadratic_fillers() -> void:
	for p in range(quadratic_points.size()):
		if not p % 2 == 0: continue
		
		if p+1 == quadratic_points.size(): break
		draw_line(quadratic_points[p], quadratic_points[p+1], Color(filler_color), quadratic_filler_width)


func draw_quadratic() -> void:
	for p in range(cubic_points.size()):
		if p+2 == cubic_points.size(): break
		draw_line(cubic_points[p], cubic_points[p+2], Color(quad_color), quadratic_width)


func draw_bezier() -> void:
	for p in range(points.size()-1):
		draw_line(points[p], points[p+1], Color.black,bezier_width + shadow_size)
		draw_line(points[p], points[p+1], Color(white_color), bezier_width)


func draw_green_circles() -> void:
	draw_a_green_circle(quadratic_points[0])
	draw_a_green_circle(quadratic_points[1])
	draw_a_green_circle(quadratic_points[quadratic_points.size()-2])
	draw_a_green_circle(quadratic_points[quadratic_points.size()-1])

func draw_a_green_circle(pos : Vector2) -> void:
	draw_circle(pos,circle_radius + shadow_size, Color.black)
	draw_circle(pos,circle_radius, Color(green_color))
