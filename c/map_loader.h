#ifndef MAP_LOADER_H
#define MAP_LOADER_H

#define MAX_CLOUD_HASH_COUNT 512

typedef struct {
    char name[20];
    float position[2];
    char hash[MAX_CLOUD_HASH_COUNT];
    int hashCount;
} Object;

typedef struct {
    float size[2];
    Object* objects;
    int objectCount;
} Map;

Map loadMap();

#endif