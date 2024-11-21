import "lib/raylib.m"

pub struct Cloud {
    x: f32
    y: f32
    signature: [2]i32
}

const baseSizeX = 160
const baseSizeY = 160

pub fn createCloud(x: f32, y: f32): Cloud {
    return .{
        x = x
        y = y
        signature = generateSignature()
    }
}

pub fn drawCloud(cloud: &Cloud) {
    for cloud.signature[0] |i| {
        const size = cloud.signature[i * 3 + 1]
        const left = cloud.signature[i * 3 + 2]
        const top = cloud.signature[i * 3 + 3]
        
        drawCircle(<i32>(cloud.x + left), <i32>(cloud.y + top), <f32>size, WHITE)
    }
}

fn generateSignature(): [dyn]i32 {
    val res: [dyn]i32 = .[]
    
    const numCircle = random(0, 10) + 10
    res.add(numCircle)
    
    for numCircle {
        const size = random(0, 50) + 15
        const left = random(0, baseSizeX)
        const top = random(0, baseSizeY)
        
        res.add(size)
        res.add(left)
        res.add(top)
    }
    
    return res
}