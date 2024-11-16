package main

import rl "github.com/gen2brain/raylib-go/raylib"

const SCREEN_WIDTH = 800
const SCREEN_HEIGHT = 600

func main() {
	rl.SetTraceLogLevel(rl.LogError)
	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Raylib Go")
	rl.SetTargetFPS(60)
	
	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(rl.DarkGray)
		rl.EndDrawing()
	}
	
	rl.CloseWindow()
}