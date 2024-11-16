declare module "raylib" {
    export function Camera2D(offset: Vector2, target: Vector2, rotation: number, zoom: number): Camera2D
    export function Vector2(x: number, y: number): Vector2
}