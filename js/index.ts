import rl from "raylib"

const screenWidth = 500
const screenHeight = 900

const gravity = 5
const maxSpeedX = 8.0
const maxSpeedY = 10.0
const forceIncrement = 1.0
const maxForce = 30.0

rl.SetTraceLogLevel(5)
rl.InitWindow(screenWidth, screenHeight, "Raylib Js")
rl.SetWindowPosition(2100, 100)
rl.SetTargetFPS(60)

let playerX = screenWidth / 2
let playerY = 0
let playerSpeedX = 0
let playerSpeedY = 0
let playerAngle = 0

let leftActive = false
let rightActive = false
let leftForce = 0
let rightForce = 0
let forceX = 0

const playerTexture = rl.LoadTexture("assets/images/player.png")
playerTexture.width = 60
playerTexture.height = 120

const camera = rl.Camera2D(rl.Vector2(0, 0), rl.Vector2(0, 0), 0, 1)

while (!rl.WindowShouldClose()) {
    update(rl.GetFrameTime())
    
    rl.BeginDrawing()
    rl.ClearBackground(rl.DARKGRAY)
    
    rl.BeginMode2D(camera)
    draw()
    
    rl.DrawRectangle(100, 1000, 100, 100, rl.RED)
    rl.DrawRectangle(400, 2000, 100, 100, rl.GREEN)
    rl.DrawRectangle(300, 4000, 100, 100, rl.BLUE)
    rl.EndMode2D()
    
    rl.DrawFPS(20, 20)
    rl.EndDrawing()
}

rl.CloseWindow()

function update(dt: number) {
    if (rl.IsKeyDown(rl.KEY_A)) {
        addRightForce(dt)
    }
    else {
        releaseRightForce()
    }
    
    if (rl.IsKeyDown(rl.KEY_D)) {
        addLeftForce(dt)
    }
    else {
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
    
    camera.offset.y = screenHeight / 8
    camera.target.y = playerY
    
    // Sementara
    if (playerY > 4500) {
        playerY = 0
    }
}

function draw() {
    const source: rl.Rectangle = {
        x: 0,
        y: 0,
        width: playerTexture.width,
        height: playerTexture.height,
    }
    
    const dest: rl.Rectangle = {
        x: playerX,
        y: playerY,
        width: playerTexture.width,
        height: playerTexture.height,
    }
    
    const origin: rl.Vector2 = {
        x: playerTexture.width / 2,
        y: playerTexture.height / 2,
    }
    
    rl.DrawTexturePro(playerTexture, source, dest, origin, playerAngle, rl.WHITE)
}

function addLeftForce(dt: number) {
    leftActive = true
    leftForce += forceIncrement * dt * 60

    if (leftForce > maxForce) {
      leftForce = maxForce
    }
}

function releaseLeftForce() {
    leftActive = false
}

function addRightForce(dt: number) {
    rightActive = true;
    rightForce += forceIncrement * dt * 60

    if (rightForce > maxForce) {
      rightForce = maxForce
    }
  }

function releaseRightForce() {
    rightActive = false
}