import rl from "raylib"

const screenWidth = 800
const screenHeight = 600

rl.SetTraceLogLevel(5)
rl.InitWindow(screenWidth, screenHeight, "Raylib Js")
rl.SetWindowPosition(2100, 100)
rl.SetTargetFPS(60)

while (!rl.WindowShouldClose()) {
    rl.BeginDrawing()
    rl.ClearBackground(rl.DARKGRAY)
    rl.EndDrawing()
}

rl.CloseWindow()