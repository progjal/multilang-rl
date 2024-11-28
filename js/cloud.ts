import rl from "raylib"

export type Cloud = {
    x: number
    y: number
    signature: number[]
}

export const cloudBaseSizeX = 160
export const cloudBaseSizeY = 160

export const importedCloudBaseSizeX = 300
export const importedCloudBaseSizeY = 300

export function createCloud(x: number, y: number): Cloud {
    return {
        x,
        y,
        signature: generateSignature(),
    }
}

export function createCloudWithSignature(x: number, y: number, hash: string): Cloud {
    return {
        x,
        y,
        signature: parseSignature(hash),
    }
}

export function drawCloud(cloud: Cloud) {
    for (let i = 0; i < cloud.signature[0]; i++) {
        const size = cloud.signature[i * 3 + 1]
        const left = cloud.signature[i * 3 + 2]
        const top = cloud.signature[i * 3 + 3]
        
        rl.DrawCircle(cloud.x + left + size / 2, cloud.y + top + size / 2, size, rl.WHITE)
    }
}

function parseSignature(hash: string): number[] {
    return hash.split(":").map(x => parseInt(x))
}

function generateSignature(): number[] {
    const res: number[] = []
	
	const numCircle = Math.random() * 10 + 10
    res.push(numCircle)
	
	for (let a = 0; a < numCircle; a++) {
		const size = Math.random() * 50 + 15
		const left = Math.random() * cloudBaseSizeX
		const top = Math.random() * cloudBaseSizeY
		
        res.push(size)
        res.push(left)
        res.push(top)
	}
	
	return res
}