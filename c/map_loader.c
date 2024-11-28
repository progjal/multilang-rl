#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "map_loader.h"
#include "json.h"

Map loadMap() {
    FILE* file = fopen("assets/map/Map.json", "r");
    long length;
    char* content;
    
    Map map = {0};
    
    if (file) {
        fseek(file, 0, SEEK_END);
        length = ftell(file);
        fseek(file, 0, SEEK_SET);
        content = malloc(length);
        
        fread(content, 1, length, file);
        
        fclose(file);
        
        json_value* json = json_parse(content, length);
        
        for (int a = 0; a < json->u.object.length; a++) {
            char* fieldName = json->u.object.values[a].name;
            json_value* value = json->u.object.values[a].value;
            printf("name : %s\n", fieldName);
            
            if (strcmp(fieldName, "size") == 0) {
                map.size[0] = value->u.array.values[0]->u.dbl;
                map.size[1] = value->u.array.values[1]->u.dbl;
            }
            else if (strcmp(fieldName, "objects") == 0) {
                map.objects = malloc(value->u.array.length * sizeof(Object));
                map.objectCount = value->u.array.length;
                
                for (int b = 0; b < value->u.array.length; b++) {
                    json_value* objJson = value->u.array.values[b];
                    
                    for (int c = 0; c < objJson->u.object.length; c++) {
                        char* objFieldName = objJson->u.object.values[c].name;
                        json_value* objValue = objJson->u.object.values[c].value;
                        
                        if (strcmp(objFieldName, "name") == 0) {
                            strcpy(map.objects[b].name, objValue->u.string.ptr);
                        }
                        else if (strcmp(objFieldName, "position") == 0) {
                            map.objects[b].position[0] = objValue->u.array.values[0]->u.dbl;
                            map.objects[b].position[1] = objValue->u.array.values[1]->u.dbl;
                        }
                        else if (strcmp(objFieldName, "hash") == 0) {
                            strcpy(map.objects[b].hash, objValue->u.string.ptr);
                            map.objects[b].hashCount = objValue->u.string.length;
                        }
                    }
                }
            }
        }
        
        json_value_free(json);
        free(content);
    }
    
    return map;
}