import "lib/raylib.m"

const SCREEN_WIDTH = 500
const SCREEN_HEIGHT = 900

const gravity = 5.0
const maxSpeedX = 8.0
const maxSpeedY = 10.0
const forceIncrement = 1.0
const maxForce = 30.0

setTraceLogLevel(5)
initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Raylib MLang")
setWindowPosition(2100, 100)
setTargetFPS(60)

val playerTexture = loadTexture("../assets/images/player.png")
playerTexture.width = 60
playerTexture.height = 120

var playerX = SCREEN_WIDTH / 2.0
var playerY = 0.0
var playerSpeedX = 0.0
var playerSpeedY = 0.0
var playerAngle = 0.0

var leftActive = false
var rightActive = false
var leftForce = 0.0
var rightForce = 0.0
var forceX = 0.0

val camera = Camera2D.{
    offset = .{0, 0}
    target = .{0, 0}
    rotation = 0
    zoom = 1
}

while !windowShouldClose() {
    update(getFrameTime())
    
    beginDrawing()
    clearBackground(DARK_GRAY)
    
    beginMode2D(camera)
    draw()
    
    drawRectangle(100, 1000, 100, 100, RED)
    drawRectangle(400, 2000, 100, 100, GREEN)
    drawRectangle(300, 4000, 100, 100, BLUE)
    
    endMode2D()
    
    drawFPS(20, 20)
    endDrawing()
}

closeWindow()

fn update(dt: f32) {
    if isKeyDown(KEY_A) {
        addRightForce(dt)
    }
    else {
        releaseRightForce()
    }
    
    if isKeyDown(KEY_D) {
        addLeftForce(dt)
    }
    else {
        releaseLeftForce()
    }
    
    playerSpeedY += dt * gravity
    
    if playerSpeedY > maxSpeedY {
        playerSpeedY = maxSpeedY
    }
    
    forceX = leftForce - rightForce

    if !leftActive {
        leftForce *= 0.7
    }

    if !rightActive {
        rightForce *= 0.7
    }
    
    playerSpeedX += dt * forceX

    if playerSpeedX > maxSpeedX {
        playerSpeedX = maxSpeedX
    }

    if playerSpeedX < -maxSpeedX {
        playerSpeedX = -maxSpeedX
    }
    
    playerX += playerSpeedX
    playerY += playerSpeedY
    playerSpeedX *= 0.995
    
    playerAngle = forceX / 3
    
    camera.offset.y = SCREEN_HEIGHT / 8.0
    camera.target.y = playerY
    
    // Sementara
    if playerY > 4500 {
        playerY = 0
    }
}

fn draw() {
    val source = Rectangle.{
        x = 0
        y = 0
        width = <f32>playerTexture.width
        height = <f32>playerTexture.height
    }
    
    val dest = Rectangle.{
        x = playerX
        y = playerY
        width = <f32>playerTexture.width
        height = <f32>playerTexture.height
    }
    
    val origin = Vector2.{
        x = <f32>playerTexture.width / 2
        y = <f32>playerTexture.height / 2
    }
    
    drawTexturePro(playerTexture, source, dest, origin, playerAngle, WHITE)
}

fn addLeftForce(dt: f32) {
    leftActive = true
    leftForce += forceIncrement * dt * 60

    if leftForce > maxForce {
      leftForce = maxForce
    }
}

fn releaseLeftForce() {
    leftActive = false
}

fn addRightForce(dt: f32) {
    rightActive = true
    rightForce += forceIncrement * dt * 60

    if rightForce > maxForce {
      rightForce = maxForce
    }
  }

fn releaseRightForce() {
    rightActive = false
}