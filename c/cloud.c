#include <stdlib.h>
#include <raylib.h>

#include "cloud.h"

#define BASE_SIZE_X 160
#define BASE_SIZE_Y 160

Cloud createCloud(float x, float y) {
    Cloud cloud = (Cloud){
        .x = x,
        .y = y,
    };
    
    generateSignature(&cloud);
    
    return cloud;
}

void drawCloud(Cloud* cloud) {
    for (int a = 0; a < cloud->signature[0]; a++) {
        int size = cloud->signature[a * 3 + 1];
        int left = cloud->signature[a * 3 + 2];
        int top = cloud->signature[a * 3 + 3];
        
        DrawCircle((int)cloud->x + left, (int)cloud->y + top, (float)size, WHITE);
    }
}

void generateSignature(Cloud* cloud) {
    int numCircle = (rand() % 10) + 10;
    cloud->signature[0] = numCircle;
    
    for (int a = 0; a < numCircle; a++) {
        int size = (rand() % 50) + 15;
        int left = rand() % BASE_SIZE_X;
        int top = rand() % BASE_SIZE_Y;
        
        cloud->signature[a * 3 + 1] = size;
        cloud->signature[a * 3 + 2] = left;
        cloud->signature[a * 3 + 3] = top;
    }
}