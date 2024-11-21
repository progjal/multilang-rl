import rl from "raylib"

export type Cloud = {
    x: number
    y: number
    signature: number[]
}

const baseSizeX = 160
const baseSizeY = 160

export function createCloud(x: number, y: number): Cloud {
    return {
        x,
        y,
        signature: generateSignature(),
    }
}

export function drawCloud(cloud: Cloud) {
    for (let i = 0; i < cloud.signature[0]; i++) {
        const size = cloud.signature[i * 3 + 1]
        const left = cloud.signature[i * 3 + 2]
        const top = cloud.signature[i * 3 + 3]
        
        rl.DrawCircle(cloud.x + left, cloud.y + top, size, rl.WHITE)
    }
}

function generateSignature(): number[] {
    const res: number[] = []
	
	const numCircle = Math.random() * 10 + 10
    res.push(numCircle)
	
	for (let a = 0; a < numCircle; a++) {
		const size = Math.random() * 50 + 15
		const left = Math.random() * baseSizeX
		const top = Math.random() * baseSizeY
		
        res.push(size)
        res.push(left)
        res.push(top)
	}
	
	return res
}