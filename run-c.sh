mkdir -p c/out

gcc c/main.c c/cloud.c c/map_loader.c c/json.c c/lib/libraylib.a -o c/out/main -I c/include -lm && c/out/main