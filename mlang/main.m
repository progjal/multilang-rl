import "lib/raylib.m"

const SCREEN_WIDTH = 800
const SCREEN_HEIGHT = 600

setTraceLogLevel(5)
initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Raylib MLang")
setWindowPosition(2100, 100)
setTargetFPS(60)

while !windowShouldClose() {
    beginDrawing()
    clearBackground(DARK_GRAY)
    endDrawing()
}

closeWindow()