package main

import (
	"encoding/json"
	"os"
)

type Object struct {
	Name string			`json:"name"`
    Position []float32  `json:"position"`
    Hash string         `json:"hash"`
}

type Map struct {
	Size []float32		`json:"size"`
	Objects []Object	`json:"objects"`
}

func loadMap() Map {
	data, err := os.ReadFile("../assets/map/Map.json")
	
	if err != nil {
		panic("Gak nemu map file")
	}
	
	theMap := Map{}
	
	err = json.Unmarshal(data, &theMap)
	
	if err != nil {
		panic("Format map gak bener")
	}
	
	return theMap
}