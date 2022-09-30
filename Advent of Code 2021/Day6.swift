//
//  Day6.swift
//  Advent of Code 2021
//
//  Created by Thomas Stidham on 1/8/22.
//

import Foundation

class Day6 {
	init(){
		consoleIO = ConsoleIO()
	}
	
	let consoleIO: ConsoleIO
	
	func Step1(DataType: String) {
		var population = [0,0,0,0,0,0,0,0,0]
		let daysToModel: Int = 256 // 80 // 18
		
		if DataType == "test" {
			for i in TestData {
				population[i] += 1
			}
		}
		else {
			for i in ProdData {
				population[i] += 1
			}
		}
		
		consoleIO.writeMessage("Starting population: \(population)")
		
		var temp: Int
		for _ in 1...daysToModel {
			// Cover ages 1 to 7
			temp = population[1]
			for c in 1...7 { // stride(from: 7, to: 0, by: -1){
				population[c] = population[c+1]
			}
			// Now handle day 0, they reset to 6 and add to 8
			population[8] = population[0]
			population[6] += population[0]
			population[0] = temp
		}
		
		var total: Int = 0
		population.forEach { x in total += x }
		
		consoleIO.writeMessage("Ending population: \(total), base: \(population)")
		
	}
	
	let TestData = [3,4,3,1,2]
	let ProdData = [4,1,1,1,5,1,3,1,5,3,4,3,3,1,3,3,1,5,3,2,4,4,3,4,1,4,2,2,1,3,5,1,1,3,2,5,1,1,4,2,5,4,3,2,5,3,3,4,5,4,3,5,4,2,5,5,2,2,2,3,5,5,4,2,1,1,5,1,4,3,2,2,1,2,1,5,3,3,3,5,1,5,4,2,2,2,1,4,2,5,2,3,3,2,3,4,4,1,4,4,3,1,1,1,1,1,4,4,5,4,2,5,1,5,4,4,5,2,3,5,4,1,4,5,2,1,1,2,5,4,5,5,1,1,1,1,1,4,5,3,1,3,4,3,3,1,5,4,2,1,4,4,4,1,1,3,1,3,5,3,1,4,5,3,5,1,1,2,2,4,4,1,4,1,3,1,1,3,1,3,3,5,4,2,1,1,2,1,2,3,3,5,4,1,1,2,1,2,5,3,1,5,4,3,1,5,2,3,4,4,3,1,1,1,2,1,1,2,1,5,4,2,2,1,4,3,1,1,1,1,3,1,5,2,4,1,3,2,3,4,3,4,2,1,2,1,2,4,2,1,5,2,2,5,5,1,1,2,3,1,1,1,3,5,1,3,5,1,3,3,2,4,5,5,3,1,4,1,5,2,4,5,5,5,2,4,2,2,5,2,4,1,3,2,1,1,4,4,1,5]
	
}
