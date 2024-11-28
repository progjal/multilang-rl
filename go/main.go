package main

import (
	"math/rand"

	rl "github.com/gen2brain/raylib-go/raylib"
)

const SCREEN_WIDTH = 500
const SCREEN_HEIGHT = 900

const IMPORTED_MAP_WIDTH = 900
const IMPORTED_MAP_HEIGHT = 1600

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

var clouds = []Cloud{}

var camera = rl.Camera2D{
	Zoom: 1,
}

var cameraTemp = rl.Camera2D{
	Zoom: 1,
}

func main() {	
	rl.SetTraceLogLevel(rl.LogError)
	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Raylib Go")
	rl.SetTargetFPS(60)

	playerTexture = rl.LoadTexture("../assets/images/player.png")
	playerTexture.Width = 60
	playerTexture.Height = 120
	
	theMap := loadMap()
	
	for _, obj := range theMap.Objects {
		if obj.Name == "Cloud" {
			cloud := createCloudWithSignature(obj.Position[0], obj.Position[1], obj.Hash)
			
			cloud.X = cloud.X * SCREEN_WIDTH / IMPORTED_MAP_WIDTH
			cloud.Y = cloud.Y * SCREEN_HEIGHT / IMPORTED_MAP_HEIGHT
			
			for a := range cloud.Signature[0] {
				cloud.Signature[a * 3 + 1] = int32(float32(cloud.Signature[a * 3 + 1]) * 0.5 * SCREEN_WIDTH / IMPORTED_MAP_WIDTH)
				cloud.Signature[a * 3 + 2] = cloud.Signature[a * 3 + 2] * SCREEN_WIDTH / IMPORTED_MAP_WIDTH
				cloud.Signature[a * 3 + 3] = cloud.Signature[a * 3 + 3] * SCREEN_HEIGHT / IMPORTED_MAP_HEIGHT
			}
			
			clouds = append(clouds, cloud)
		}
	}
	
	for !rl.WindowShouldClose() {
		update(rl.GetFrameTime())
		
		rl.BeginDrawing()
		rl.ClearBackground(rl.DarkGray)
		
		rl.BeginMode2D(camera)
		draw()
		
		for _, cloud := range clouds {
			cloud.draw()
		}
		
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
    // if playerY > 4500 {
    //     playerY = 0
    // }
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
	
	if leftForce > 1 {
        randW := float32(rand.Intn(8))
        w := leftForce + randW
        const h = 10
        
        cameraTemp.Rotation = -25 + playerAngle
        cameraTemp.Target.X = playerX
        cameraTemp.Target.Y = playerY
        cameraTemp.Offset.X = playerX - float32(playerTexture.Width)
        cameraTemp.Offset.Y = float32(SCREEN_HEIGHT) / 8 + float32(playerTexture.Height) / 4
        
        rl.BeginMode2D(cameraTemp)
        rl.DrawEllipse(int32(playerX), int32(playerY), w, h, rl.Orange)
        rl.EndMode2D()
    }
    
    if rightForce > 1 {
        randW := float32(rand.Intn(8))
        w := rightForce + randW
        const h = 10
        
        cameraTemp.Rotation = 25 + playerAngle
        cameraTemp.Target.X = playerX
        cameraTemp.Target.Y = playerY
        cameraTemp.Offset.X = playerX + float32(playerTexture.Width)
        cameraTemp.Offset.Y = float32(SCREEN_HEIGHT) / 8 + float32(playerTexture.Height) / 4
        
        rl.BeginMode2D(cameraTemp)
        rl.DrawEllipse(int32(playerX), int32(playerY), w, h, rl.Orange)
        rl.EndMode2D()
    }
    
    rl.BeginMode2D(camera)
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