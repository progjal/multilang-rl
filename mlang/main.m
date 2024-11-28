import "lib/raylib.m"
import "cloud.m"
import "map_loader.m"

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

val clouds: [dyn]Cloud = .[]

[[ loadMap() ]]

clouds.add(createCloud(100, 1000))
clouds.add(createCloud(400, 2000))
clouds.add(createCloud(300, 4000))

val camera = Camera2D.{
    offset = .{0, 0}
    target = .{0, 0}
    rotation = 0
    zoom = 1
}

val cameraTemp = Camera2D.{
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
    
    if leftForce > 1 {
        const randW = <f32>random(0, 8)
        const w = leftForce + randW
        const h = 10.0
        
        cameraTemp.rotation = -25 + playerAngle
        cameraTemp.target.x = playerX
        cameraTemp.target.y = playerY
        cameraTemp.offset.x = playerX - playerTexture.width
        cameraTemp.offset.y = <f32>SCREEN_HEIGHT / 8 + playerTexture.height / 4
        
        beginMode2D(cameraTemp)
        drawEllipse(<i32>playerX, <i32>playerY, w, h, ORANGE)
        endMode2D()
    }
    
    if (rightForce > 1) {
        const randW = <f32>random(0, 8)
        const w = rightForce + randW
        const h = 10.0
        
        cameraTemp.rotation = 25 + playerAngle
        cameraTemp.target.x = playerX
        cameraTemp.target.y = playerY
        cameraTemp.offset.x = playerX + playerTexture.width
        cameraTemp.offset.y = <f32>SCREEN_HEIGHT / 8 + playerTexture.height / 4
        
        beginMode2D(cameraTemp)
        drawEllipse(<i32>playerX, <i32>playerY, w, h, ORANGE)
        endMode2D()
    }
    
    beginMode2D(camera)
    
    for clouds |cloud| {
        drawCloud(&cloud)
    }
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