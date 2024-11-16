pub struct Texture {
    id: u32
    width: i32
    height: i32
    mipmaps: i32
    format: i32
}

pub struct Rectangle {
    x: f32
    y: f32
    width: f32
    height: f32
}

pub struct Vector2 {
    x: f32
    y: f32
}

pub struct AudioStream {
    buffer: u64
    processor: u64
    sampleRate: u32
    sampleSize: u32
    channels: u32
}

pub struct Sound {
    stream: AudioStream
    frameCount: u32
}

pub struct Music {
    stream: AudioStream
    
    frameCount: u32
    looping: u8
    ctxType: i32
    ctxData: u64
}

pub dlimport "raylib" {
    @extern(name = "InitWindow")            fn initWindow(width: i32, height: i32, title: string)
    @extern(name = "CloseWindow")           fn closeWindow()
    @extern(name = "WindowShouldClose")     fn windowShouldClose(): bool
    @extern(name = "BeginDrawing")          fn beginDrawing()
    @extern(name = "EndDrawing")            fn endDrawing()
    @extern(name = "ClearBackground")       fn clearBackground(color: i32)
    
    @extern(name = "InitAudioDevice")       fn initAudioDevice()
    @extern(name = "LoadSound")             fn loadSound(path: string): Sound
    @extern(name = "PlaySound")             fn playSound(sound: Sound)
    @extern(name = "LoadMusicStream")       fn loadMusicStream(path: string): Music
    @extern(name = "IsMusicReady")          fn isMusicReady(music: Music): bool
    @extern(name = "UnloadMusicStream")     fn unloadMusicStream(music: Music)
    @extern(name = "PlayMusicStream")       fn playMusicStream(music: Music)
    @extern(name = "IsMusicStreamPlaying")  fn isMusicStreamPlaying(music: Music): bool
    @extern(name = "UpdateMusicStream")     fn updateMusicStream(music: Music)
    @extern(name = "StopMusicStream")       fn stopMusicStream(music: Music)
    @extern(name = "PauseMusicStream")      fn pauseMusicStream(music: Music)
    @extern(name = "ResumeMusicStream")     fn resumeMusicStream(music: Music)
    @extern(name = "SeekMusicStream")       fn seekMusicStream(music: Music, value: f32)
    @extern(name = "SetMusicVolume")        fn setMusicVolume(music: Music, value: f32)
    @extern(name = "SetMusicPitch")         fn setMusicPitch(music: Music, value: f32)
    @extern(name = "SetMusicPan")           fn setMusicPan(music: Music, value: f32)
    
    @extern(name = "SetTraceLogLevel")      fn setTraceLogLevel(level: i32)
    @extern(name = "SetWindowState")        fn setWindowState(state: i32)
    @extern(name = "SetWindowPosition")     fn setWindowPosition(x: i32, y: i32)
    @extern(name = "SetTargetFPS")          fn setTargetFPS(fps: i32)
    @extern(name = "DrawFPS")               fn drawFPS(x: i32, y: i32)
    @extern(name = "GetFPS")                fn getFPS(): i32
    @extern(name = "GetFrameTime")          fn getFrameTime(): f32
    @extern(name = "MeasureText")           fn measureText(text: string, fontSize: i32): i32
    
    @extern(name = "DrawRectangle")         fn drawRectangle(x: i32, y: i32, w: i32, h: i32, color: i32)
    @extern(name = "DrawRectanglePro")      fn drawRectanglePro(rec: Rectangle, origin: Vector2, rotation: f32, color: i32)
    @extern(name = "DrawLine")              fn drawLine(x1: i32, y1: i32, x2: i32, y2: i32, color: i32)
    
    @extern(name = "LoadTexture")           fn loadTexture(path: string): Texture
    @extern(name = "DrawTexture")           fn drawTexture(texture: Texture, x: i32, y: i32, tint: i32)
    @extern(name = "DrawTextureRec")        fn drawTextureRec(texture: Texture, rec: Rectangle,
                                                              pos: Vector2, tint: i32)
    @extern(name = "DrawText")              fn drawText(text: string, x: i32, y: i32, size: i32, color: i32)
    
    @extern(name = "IsKeyPressed")          fn isKeyPressed(key: i32): bool
    @extern(name = "IsKeyReleased")         fn isKeyReleased(key: i32): bool
    @extern(name = "IsKeyDown")             fn isKeyDown(key: i32): bool
    @extern(name = "IsKeyUp")               fn isKeyUp(key: i32): bool
    
    @extern(name = "IsMouseButtonPressed")  fn isMouseButtonPressed(button: i32): bool
    @extern(name = "IsMouseButtonDown")     fn isMouseButtonDown(button: i32): bool
    @extern(name = "IsMouseButtonReleased") fn isMouseButtonReleased(button: i32): bool
    @extern(name = "IsMouseButtonUp")       fn isMouseButtonUp(button: i32): bool
    @extern(name = "GetMouseX")             fn getMouseX(): i32
    @extern(name = "GetMouseY")             fn getMouseY(): i32
}

pub const RED       = 0xFF0000FF
pub const BLUE      = 0xFFFF0000
pub const GREEN     = 0xFF00FF00
pub const WHITE     = 0xFFFFFFFF
pub const GRAY      = 0xFF999999
pub const DARK_GRAY = 0xFF505050
pub const DARK      = 0xFF222222

pub const KEY_NULL            = 0
pub const KEY_APOSTROPHE      = 39
pub const KEY_COMMA           = 44
pub const KEY_MINUS           = 45
pub const KEY_PERIOD          = 46
pub const KEY_SLASH           = 47
pub const KEY_ZERO            = 48
pub const KEY_ONE             = 49
pub const KEY_TWO             = 50
pub const KEY_THREE           = 51
pub const KEY_FOUR            = 52
pub const KEY_FIVE            = 53
pub const KEY_SIX             = 54
pub const KEY_SEVEN           = 55
pub const KEY_EIGHT           = 56
pub const KEY_NINE            = 57
pub const KEY_SEMICOLON       = 59
pub const KEY_EQUAL           = 61
pub const KEY_A               = 65
pub const KEY_B               = 66
pub const KEY_C               = 67
pub const KEY_D               = 68
pub const KEY_E               = 69
pub const KEY_F               = 70
pub const KEY_G               = 71
pub const KEY_H               = 72
pub const KEY_I               = 73
pub const KEY_J               = 74
pub const KEY_K               = 75
pub const KEY_L               = 76
pub const KEY_M               = 77
pub const KEY_N               = 78
pub const KEY_O               = 79
pub const KEY_P               = 80
pub const KEY_Q               = 81
pub const KEY_R               = 82
pub const KEY_S               = 83
pub const KEY_T               = 84
pub const KEY_U               = 85
pub const KEY_V               = 86
pub const KEY_W               = 87
pub const KEY_X               = 88
pub const KEY_Y               = 89
pub const KEY_Z               = 90
pub const KEY_LEFT_BRACKET    = 91
pub const KEY_BACKSLASH       = 92
pub const KEY_RIGHT_BRACKET   = 93
pub const KEY_GRAVE           = 96
pub const KEY_SPACE           = 32
pub const KEY_ESCAPE          = 256
pub const KEY_ENTER           = 257
pub const KEY_TAB             = 258
pub const KEY_BACKSPACE       = 259
pub const KEY_INSERT          = 260
pub const KEY_DELETE          = 261
pub const KEY_RIGHT           = 262
pub const KEY_LEFT            = 263
pub const KEY_DOWN            = 264
pub const KEY_UP              = 265
pub const KEY_PAGE_UP         = 266
pub const KEY_PAGE_DOWN       = 267
pub const KEY_HOME            = 268
pub const KEY_END             = 269
pub const KEY_CAPS_LOCK       = 280
pub const KEY_SCROLL_LOCK     = 281
pub const KEY_NUM_LOCK        = 282
pub const KEY_PRINT_SCREEN    = 283
pub const KEY_PAUSE           = 284
pub const KEY_F1              = 290
pub const KEY_F2              = 291
pub const KEY_F3              = 292
pub const KEY_F4              = 293
pub const KEY_F5              = 294
pub const KEY_F6              = 295
pub const KEY_F7              = 296
pub const KEY_F8              = 297
pub const KEY_F9              = 298
pub const KEY_F10             = 299
pub const KEY_F11             = 300
pub const KEY_F12             = 301
pub const KEY_LEFT_SHIFT      = 340
pub const KEY_LEFT_CONTROL    = 341
pub const KEY_LEFT_ALT        = 342
pub const KEY_LEFT_SUPER      = 343
pub const KEY_RIGHT_SHIFT     = 344
pub const KEY_RIGHT_CONTROL   = 345
pub const KEY_RIGHT_ALT       = 346
pub const KEY_RIGHT_SUPER     = 347
pub const KEY_KB_MENU         = 348
pub const KEY_KP_0            = 320
pub const KEY_KP_1            = 321
pub const KEY_KP_2            = 322
pub const KEY_KP_3            = 323
pub const KEY_KP_4            = 324
pub const KEY_KP_5            = 325
pub const KEY_KP_6            = 326
pub const KEY_KP_7            = 327
pub const KEY_KP_8            = 328
pub const KEY_KP_9            = 329
pub const KEY_KP_DECIMAL      = 330
pub const KEY_KP_DIVIDE       = 331
pub const KEY_KP_MULTIPLY     = 332
pub const KEY_KP_SUBTRACT     = 333
pub const KEY_KP_ADD          = 334
pub const KEY_KP_ENTER        = 335
pub const KEY_KP_EQUAL        = 336
pub const KEY_BACK            = 4
pub const KEY_MENU            = 82
pub const KEY_VOLUME_UP       = 24
pub const KEY_VOLUME_DOWN     = 25

pub const MOUSE_BUTTON_LEFT    = 0
pub const MOUSE_BUTTON_RIGHT   = 1
pub const MOUSE_BUTTON_MIDDLE  = 2
pub const MOUSE_BUTTON_SIDE    = 3
pub const MOUSE_BUTTON_EXTRA   = 4
pub const MOUSE_BUTTON_FORWARD = 5
pub const MOUSE_BUTTON_BACK    = 6