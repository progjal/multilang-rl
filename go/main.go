package main

import (
	rl "github.com/gen2brain/raylib-go/raylib"
)

const SCREEN_WIDTH = 500
const SCREEN_HEIGHT = 900

const gravity float32 = 5
const maxSpeedX float32 = 8.0
const maxSpeedY float32 = 10.0
const forceIncrement float32 = 1.0
const maxForce float32 = 30.0

var playerTexture rl.Texture2D

var playerX float32 = SCREEN_WIDTH / 2
var playerY float32 = 0.0
var playerSpeedX float32 = 0.0
var playerSpeedY float32 = 0.0
var playerAngle float32 = 0

var leftActive = false
var rightActive = false
var leftForce float32 = 0
var rightForce float32 = 0
var forceX float32 = 0

var camera = rl.Camera2D{
	Zoom: 1,
}

func main() {
	rl.SetTraceLogLevel(rl.LogError)
	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Raylib Go")
	rl.SetTargetFPS(60)

	playerTexture = rl.LoadTexture("../assets/images/player.png")
	playerTexture.Width = 60
	playerTexture.Height = 120
	
	for !rl.WindowShouldClose() {
		update(rl.GetFrameTime())
		
		rl.BeginDrawing()
		rl.ClearBackground(rl.DarkGray)
		
		rl.BeginMode2D(camera)
		draw()
		
		rl.DrawRectangle(100, 1000, 100, 100, rl.Red)
		rl.DrawRectangle(400, 2000, 100, 100, rl.Green)
		rl.DrawRectangle(300, 4000, 100, 100, rl.Blue)
		
		rl.EndMode2D()
		
		rl.DrawFPS(20, 20)
		rl.EndDrawing()
	}
	
	rl.CloseWindow()
}

func update(dt float32) {
	if rl.IsKeyDown(rl.KeyA) {
        addRightForce(dt)
    } else {
        releaseRightForce()
    }
    
    if rl.IsKeyDown(rl.KeyD) {
        addLeftForce(dt)
    } else {
        releaseLeftForce()
    }
	
	playerSpeedY += dt * gravity
    
    if (playerSpeedY > maxSpeedY) {
        playerSpeedY = maxSpeedY
    }
    
	forceX = leftForce - rightForce

    if (!leftActive) {
      leftForce *= 0.7
    }

    if (!rightActive) {
      rightForce *= 0.7
    }
    
    playerSpeedX += dt * forceX

    if (playerSpeedX > maxSpeedX) {
      playerSpeedX = maxSpeedX
    }

    if (playerSpeedX < -maxSpeedX) {
      playerSpeedX = -maxSpeedX
    }
    
    playerX += playerSpeedX
    playerY += playerSpeedY
    playerSpeedX *= 0.995
	
	playerAngle = forceX / 3
	
	camera.Offset.Y = SCREEN_HEIGHT / 8
    camera.Target.Y = playerY
    
    // Sementara
    if playerY > 4500 {
        playerY = 0
    }
}

func draw() {
	source := rl.Rectangle{
        X: 0,
        Y: 0,
        Width: float32(playerTexture.Width),
        Height: float32(playerTexture.Height),
    }
    
    dest := rl.Rectangle{
        X: playerX,
        Y: playerY,
        Width: float32(playerTexture.Width),
        Height: float32(playerTexture.Height),
    }
    
    origin := rl.Vector2{
        X: float32(playerTexture.Width) / 2,
        Y: float32(playerTexture.Height) / 2,
    }
    
    rl.DrawTexturePro(playerTexture, source, dest, origin, playerAngle, rl.White)
}

func addLeftForce(dt float32) {
    leftActive = true
    leftForce += forceIncrement * dt * 60

    if leftForce > maxForce {
      leftForce = maxForce
    }
}

func releaseLeftForce() {
    leftActive = false
}

func addRightForce(dt float32) {
    rightActive = true
    rightForce += forceIncrement * dt * 60

    if rightForce > maxForce {
      rightForce = maxForce
    }
  }

func releaseRightForce() {
    rightActive = false
}