//
//  Day3.swift
//  Advent of Code 2021
//
//  Created by Thomas Stidham on 1/1/22.
//

import Foundation

class Day3 {
	let consoleIO = ConsoleIO()
	let state = "prod"
	let dr = DiagnosticReport()
	
	let diagReadings: [String]
	init() {
		diagReadings = dr.GetDiagnosticsString(dataType: state)
	}
	
	func Diagnostics() {
		consoleIO.writeMessage("Diagnostics by binary value")
		let d = dr.GetDiagnostics(dataType: state)
		
		// Number of siginificant digits in binary number minus 1 since we are 0 based
		let digits = Int (floor( log2( Double (d.max() ?? 0) )))
		
		// An array to hold count of diagnotic report items
		var diagR: [Int] = []
		
		// Initialize the array
		for _ in 0...digits {
			diagR.append(0)
		}
		
		// Use for finding if specific bit is set to 1
		var powerOfTwo: UInt16
		
		for n in d {
			powerOfTwo = UInt16(pow(2, Double(digits)))
			
			for i in 0...digits {
				if (n & powerOfTwo == powerOfTwo) {
					diagR[i] += 1
				}
				
				powerOfTwo /= 2
			}
		}
		
		var gamma = UInt16(0)
		var epsilon = UInt16(0)
		powerOfTwo = UInt16(pow(2, Double(digits)))
		
		for i in diagR {
			if (i > d.count / 2) {
				gamma += powerOfTwo
			}
			else {
				epsilon += powerOfTwo
			}
			powerOfTwo /= 2
		}
		
		consoleIO.writeMessage("Gamma: \(gamma)")
		consoleIO.writeMessage("Epsilon: \(epsilon)")
		consoleIO.writeMessage("Power consumption: \(Int(gamma) * Int(epsilon))")
	}
	
	func DiagnosticsString() {
		consoleIO.writeMessage("Diagnostics by string value")
		if diagReadings.count == 0 {
			consoleIO.writeMessage("No input available")
			return;
		}
		
		// Number of siginificant digits in binary number minus 1 since we are 0 based
		let digits = diagReadings[0].count - 1
		
		// An array to hold count of diagnotic report items
		var diagR: [Int] = []
		
		// Initialize the array
		for _ in 0...digits {
			diagR.append(0)
		}
		var i = 0
		for diags in diagReadings {
			i = 0
			for c in diags.indices {
				if diags[c] == "1" {
					diagR[i] += 1
				}
				i += 1
			}
		}
		
		var gamma = 0
		var epsilon = 0
		var powerOfTwo = Int(pow(2, Double(digits)))
		var gs: [String] = []
		var es: [String] = []
		
		for i in diagR {
			if (i > diagReadings.count - i) {
				gamma += powerOfTwo
				gs.append("1")
				es.append("0")
			}
			else {
				epsilon += powerOfTwo
				gs.append("0")
				es.append("1")
			}
			powerOfTwo /= 2
		}
		
		consoleIO.writeMessage("Gamma: \(gamma), \(gs)")
		consoleIO.writeMessage("Epsilon: \(epsilon), \(es)")
		consoleIO.writeMessage("Power consumption: \(gamma * epsilon)")
	}
	
	
	func LifeSupportRating() {
		consoleIO.writeMessage("Life Support rating by string value")
		if diagReadings.count == 0 {
			consoleIO.writeMessage("No input available")
			return;
		}
		
		var c = 0
		var results = diagReadings
		var bitCount: Int
		var searchValue: Character
		let digits = results[0].count
		
		// Oxygen generator rating - look for most common value in bit position
		repeat {
			bitCount = CountOneAtPosition(reports: results, position: c)
			
			if (bitCount >= results.count - bitCount) {
				searchValue = "1"
			}
			else {
				searchValue = "0"
			}
			
			results = FilterValues(results: results, searchValue: searchValue, position: c)
			
			c += 1
		} while results.count > 1 && c < digits
		
		var oxygenRating = "0"
		if results.count == 1 {
			oxygenRating = results[0]
		}
		
		results = diagReadings
		c = 0
		// CO2 scrubber rating - look for least common value in bit position
		repeat {
			bitCount = CountOneAtPosition(reports: results, position: c)
			if (bitCount < results.count - bitCount) {
				searchValue = "1"
			}
			else {
				searchValue = "0"
			}
			
			results = FilterValues(results: results, searchValue: searchValue, position: c)
			
			c += 1
		} while results.count > 1 && c < digits
		
		var co2Rating = "0"
		if results.count == 1 {
			co2Rating = results[0]
		}
		
		consoleIO.writeMessage("Oxygen generator rating: \(oxygenRating)")
		consoleIO.writeMessage("CO2 scrubber rating:     \(co2Rating)")
		
		let oxyInt = strtoul(String(oxygenRating), nil, 2)
		let co2Int = strtoul(String(co2Rating), nil, 2)
		consoleIO.writeMessage("Life support rating: \(oxyInt) times \(co2Int) is \(oxyInt * co2Int)")
	}
	
	private func CountOneAtPosition(reports: [String], position: Int) -> Int {
		var oneCount = 0
		for diags in reports {
			let c = diags.index(diags.startIndex, offsetBy: position)
			if diags[c] == "1" {
				oneCount += 1
			}
		}
		
		return oneCount
	}
	
	private func FilterValues(results: [String], searchValue: Character, position: Int) -> [String] {
		var temp: [String] = []
		for r in results {
			let c = r.index(r.startIndex, offsetBy: position)
			if r[c] == searchValue {
				temp.append(r)
			}
		}
		
		return temp
	}
}
