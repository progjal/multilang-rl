#include <stdio.h>
#include <raylib.h>
#include <stdbool.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>

#include "cloud.h"
#include "map_loader.h"

#define SCREEN_WIDTH 500
#define SCREEN_HEIGHT 900

#define IMPORTED_MAP_WIDTH 900
#define IMPORTED_MAP_HEIGHT 1600

#define GRAVITY 5.0
#define MAX_SPEED_X 8.0
#define MAX_SPEED_Y 10.0
#define FORCE_INCREMENT 1.0
#define MAX_FORCE 30.0

Texture2D playerTexture;

float playerX = SCREEN_WIDTH / 2;
float playerY = 0.0;
float playerSpeedX = 0.0;
float playerSpeedY = 0.0;
float playerAngle = 0.0;

bool leftActive = false;
bool rightActive = false;
float leftForce = 0;
float rightForce= 0;
float forceX = 0;

#define MAX_CLOUD 100
Cloud clouds[MAX_CLOUD];
int cloudCount = 0;

Camera2D camera = (Camera2D){
    .zoom = 1,
};

Camera2D cameraTemp = (Camera2D){
    .zoom = 1,
};

void update(float dt);
void draw();
void addLeftForce(float dt);
void addRightForce(float dt);
void releaseLeftForce();
void releaseRightForce();

int main() {
    srand(time(NULL));
    
    SetTraceLogLevel(LOG_ERROR);
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Raylib C");
    SetWindowPosition(2100, 100);
    SetTargetFPS(60);
    
    playerTexture = LoadTexture("assets/images/player.png");
    playerTexture.width = 60;
    playerTexture.height = 120;
    
    Map map = loadMap();
    
    printf("size { %f, %f }\n", map.size[0], map.size[1]);
    
    for (int a = 0; a < map.objectCount; a++) {        
        if (strcmp(map.objects[a].name, "Cloud") == 0) {
            Cloud cloud = createCloudWithSignature(map.objects[a].position[0], map.objects[a].position[1], map.objects[a].hash, map.objects[a].hashCount);
            
			cloud.x = cloud.x * SCREEN_WIDTH / IMPORTED_MAP_WIDTH;
			cloud.y = cloud.y * SCREEN_HEIGHT / IMPORTED_MAP_HEIGHT;
			
            printf("%f %f\n", cloud.x, cloud.y);
            
			for (int b = 0; b < cloud.signature[0]; b++) {
				cloud.signature[b * 3 + 1] = (int)cloud.signature[b * 3 + 1] * 0.5 * SCREEN_WIDTH / IMPORTED_MAP_WIDTH;
				cloud.signature[b * 3 + 2] = cloud.signature[b * 3 + 2] * SCREEN_WIDTH / IMPORTED_MAP_WIDTH;
				cloud.signature[b * 3 + 3] = cloud.signature[b * 3 + 3] * SCREEN_HEIGHT / IMPORTED_MAP_HEIGHT;
			}
			
            clouds[cloudCount++] = cloud;
        }
    }
    
    while (!WindowShouldClose()) {
        update(GetFrameTime());
        
        BeginDrawing();
        ClearBackground(DARKGRAY);
        
        BeginMode2D(camera);
        draw();
        
        for (int a = 0; a < cloudCount; a++) {
            drawCloud(&clouds[a]);
        }
        
        EndMode2D();
        
        DrawFPS(20, 20);
        EndDrawing();
    }
    
    CloseWindow();
    
    return 0;
}

void update(float dt) {
    if (IsKeyDown(KEY_A)) {
        addRightForce(dt);
    }
    else {
        releaseRightForce();
    }
    
    if (IsKeyDown(KEY_D)) {
        addLeftForce(dt);
    }
    else {
        releaseLeftForce();
    }
    
    playerSpeedY += dt * GRAVITY;
    
    if (playerSpeedY > MAX_SPEED_Y) {
        playerSpeedY = MAX_SPEED_Y;
    }
    
    forceX = leftForce - rightForce;

    if (!leftActive) {
      leftForce *= 0.7;
    }

    if (!rightActive) {
      rightForce *= 0.7;
    }
    
    playerSpeedX += dt * forceX;

    if (playerSpeedX > MAX_SPEED_X) {
      playerSpeedX = MAX_SPEED_X;
    }

    if (playerSpeedX < -MAX_SPEED_X) {
      playerSpeedX = -MAX_SPEED_X;
    }
    
    playerX += playerSpeedX;
    playerY += playerSpeedY;
    playerSpeedX *= 0.995;
    
    playerAngle = forceX / 3;
    
	camera.offset.y = SCREEN_HEIGHT / 8;
    camera.target.y = playerY;
    
    // Sementara
    // if (playerY > 4500) {
    //     playerY = 0;
    // }
}

void draw() {
    Rectangle source = (Rectangle){
        .x = 0,
        .y = 0,
        .width = playerTexture.width,
        .height = playerTexture.height,
    };
    
    Rectangle dest = (Rectangle){
        .x = playerX,
        .y = playerY,
        .width = playerTexture.width,
        .height = playerTexture.height,
    };
    
    Vector2 origin = (Vector2){
        .x = (float)playerTexture.width / 2,
        .y = (float)playerTexture.height / 2,
    };
    
    DrawTexturePro(playerTexture, source, dest, origin, playerAngle, WHITE);
    
    if (leftForce > 1) {
        float randW = (float)rand() / RAND_MAX;
        float w = leftForce + randW;
        float h = 10;
        
        cameraTemp.rotation = -25 + playerAngle;
        cameraTemp.target.x = playerX;
        cameraTemp.target.y = playerY;
        cameraTemp.offset.x = playerX - playerTexture.width;
        cameraTemp.offset.y = SCREEN_HEIGHT / 8 + playerTexture.height / 4;
        
        BeginMode2D(cameraTemp);
        DrawEllipse(playerX, playerY, w, h, ORANGE);
        EndMode2D();
    }
    
    if (rightForce > 1) {
        float randW = (float)rand() / RAND_MAX;
        float w = rightForce + randW;
        float h = 10;
        
        cameraTemp.rotation = 25 + playerAngle;
        cameraTemp.target.x = playerX;
        cameraTemp.target.y = playerY;
        cameraTemp.offset.x = playerX + playerTexture.width;
        cameraTemp.offset.y = SCREEN_HEIGHT / 8 + playerTexture.height / 4;
        
        BeginMode2D(cameraTemp);
        DrawEllipse(playerX, playerY, w, h, ORANGE);
        EndMode2D();
    }
    
    BeginMode2D(camera);
}

void addLeftForce(float dt) {
    leftActive = true;
    leftForce += FORCE_INCREMENT * dt * 60;

    if (leftForce > MAX_FORCE) {
      leftForce = MAX_FORCE;
    }
}

void releaseLeftForce() {
    leftActive = false;
}

void addRightForce(float dt) {
    rightActive = true;
    rightForce += FORCE_INCREMENT * dt * 60;

    if (rightForce > MAX_FORCE) {
      rightForce = MAX_FORCE;
    }
  }

void releaseRightForce() {
    rightActive = false;
}