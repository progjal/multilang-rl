#ifndef CLOUD_H
#define CLOUD_H

#define MAX_CLOUD_CIRCLE_COUNT 20
#define CLOUD_SIGNATURE_COUNT MAX_CLOUD_CIRCLE_COUNT * 3 + 1

typedef struct {
    float x;
    float y;
    int signature[CLOUD_SIGNATURE_COUNT];
} Cloud;

Cloud createCloud(float x, float y);
Cloud createCloudWithSignature(float x, float y, char* hash, int hashCount);
void drawCloud(Cloud* cloud);

#endif