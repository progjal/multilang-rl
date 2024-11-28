import fs from "fs"

export type ObjectPlayer = {
    name: "Player"
    position: [number, number]
}

export type ObjectCloud = {
    name: "Cloud"
    position: [number, number]
    size: [number, number]
    hash: string
    color: number
}

export type ObjectWind = {
    name: "Wind"
    position: [number, number]
}

export type ObjectTrampoline = {
    name: "Trampoline"
    position: [number, number]
}

export type ObjectHelicopter = {
    name: "Helicopter"
    position: [number, number]
}

export type Object = ObjectPlayer | ObjectCloud | ObjectWind | ObjectTrampoline | ObjectHelicopter

export type Map = {
    size: [number, number]
    objects: Object[]
}

export function loadMap(): Map {
    const content = fs.readFileSync("assets/map/Map.json").toString()
    const json = JSON.parse(content) as Map
    
    return json
}