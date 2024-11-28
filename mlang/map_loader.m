pub struct Object {
    name: string
    position: []f32
    hash: string
}

pub struct Map {
    size: []f32
    objects: []Object
}

pub fn loadMap(): Map {
    const map = <Map>jsonDecode(Map, readFile("../assets/map/Map.json"))
    
    [[ map ]]
    
    return map
}