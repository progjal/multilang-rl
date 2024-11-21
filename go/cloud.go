package main

import (
	"math/rand"

	rl "github.com/gen2brain/raylib-go/raylib"
)

type Cloud struct {
	X float32
	Y float32
	Signature []int32
}

const baseSizeX = 160
const baseSizeY = 160

func createCloud(x float32, y float32) Cloud {
	return Cloud{
		X: x,
		Y: y,
		Signature: generateSignature(),
	}
}

func (cloud *Cloud) draw() {
	for i := range cloud.Signature[0] {
        size := cloud.Signature[i * 3 + 1]
        left := cloud.Signature[i * 3 + 2]
        top := cloud.Signature[i * 3 + 3]
        
        rl.DrawCircle(int32(cloud.X) + left, int32(cloud.Y) + top, float32(size), rl.White)
    }
}

func generateSignature() []int32 {
	res := []int32{}
	
	numCircle := rand.Intn(10) + 10
	res = append(res, int32(numCircle))
	
	for range numCircle {
		size := rand.Intn(50) + 15
		left := rand.Intn(baseSizeX)
		top := rand.Intn(baseSizeY)
		
		res = append(res, int32(size))
		res = append(res, int32(left))
		res = append(res, int32(top))
	}
	
	return res
}