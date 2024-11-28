import rl from "raylib"
import { Cloud, createCloudWithSignature, drawCloud } from "./cloud"
import { loadMap } from "./map_loader"

const SCREEN_WIDTH = 500
const SCREEN_HEIGHT = 900

const IMPORTED_MAP_WIDTH = 900
const IMPORTED_MAP_HEIGHT = 1600

const gravity = 5
const maxSpeedX = 8.0
const maxSpeedY = 10.0
const forceIncrement = 1.0
const maxForce = 30.0

rl.SetTraceLogLevel(5)
rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Raylib Js")
rl.SetWindowPosition(2100, 100)
rl.SetTargetFPS(60)

let playerX = SCREEN_WIDTH / 2
let playerY = 0
let playerSpeedX = 0
let playerSpeedY = 0
let playerAngle = 0

let leftActive = false
let rightActive = false
let leftForce = 0
let rightForce = 0
let forceX = 0

const clouds: Cloud[] = []
const map = loadMap()

for (const obj of map.objects) {
    if (obj.name === "Cloud") {
        const cloud = createCloudWithSignature(obj.position[0], obj.position[1], obj.hash)
        
        cloud.x = cloud.x * SCREEN_WIDTH / IMPORTED_MAP_WIDTH
        cloud.y = cloud.y * SCREEN_HEIGHT / IMPORTED_MAP_HEIGHT
        
        for (let a = 0; a < cloud.signature[0]; a++) {
            cloud.signature[a * 3 + 1] = cloud.signature[a * 3 + 1] * 0.5 * SCREEN_WIDTH / IMPORTED_MAP_WIDTH
            cloud.signature[a * 3 + 2] = cloud.signature[a * 3 + 2] * SCREEN_WIDTH / IMPORTED_MAP_WIDTH
            cloud.signature[a * 3 + 3] = cloud.signature[a * 3 + 3] * SCREEN_HEIGHT / IMPORTED_MAP_HEIGHT
        }
        
        clouds.push(cloud)
    }
}

const playerTexture = rl.LoadTexture("assets/images/player.png")
playerTexture.width = 60
playerTexture.height = 120

const camera = rl.Camera2D(rl.Vector2(0, 0), rl.Vector2(0, 0), 0, 1)
const cameraTemp = rl.Camera2D(rl.Vector2(0, 0), rl.Vector2(0, 0), 0, 1)

let paused = false

while (!rl.WindowShouldClose()) {
    if (rl.IsKeyPressed(rl.KEY_SPACE)) {
        paused = !paused
    }
    
    if (!paused) {
        update(rl.GetFrameTime())
    }
    
    rl.BeginDrawing()
    rl.ClearBackground(rl.DARKGRAY)
    
    rl.BeginMode2D(camera)
    draw()
    
    for (const cloud of clouds) {
        drawCloud(cloud)
    }
    
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
    
    camera.offset.y = SCREEN_HEIGHT / 8
    camera.target.y = playerY
    
    // Sementara
    // if (playerY > 4500) {
    //     playerY = 0
    // }
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
    
    if (leftForce > 1) {
        const randW = Math.random() * 8
        const w = leftForce + randW
        const h = 10
        
        cameraTemp.rotation = -25 + playerAngle
        cameraTemp.target.x = playerX
        cameraTemp.target.y = playerY
        cameraTemp.offset.x = playerX - playerTexture.width
        cameraTemp.offset.y = SCREEN_HEIGHT / 8 + playerTexture.height / 4
        
        rl.BeginMode2D(cameraTemp)
        rl.DrawEllipse(playerX, playerY, w, h, rl.ORANGE)
        rl.EndMode2D()
    }
    
    if (rightForce > 1) {
        const randW = Math.random() * 8
        const w = rightForce + randW
        const h = 10
        
        cameraTemp.rotation = 25 + playerAngle
        cameraTemp.target.x = playerX
        cameraTemp.target.y = playerY
        cameraTemp.offset.x = playerX + playerTexture.width
        cameraTemp.offset.y = SCREEN_HEIGHT / 8 + playerTexture.height / 4
        
        rl.BeginMode2D(cameraTemp)
        rl.DrawEllipse(playerX, playerY, w, h, rl.ORANGE)
        rl.EndMode2D()
    }
    
    rl.BeginMode2D(camera)
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