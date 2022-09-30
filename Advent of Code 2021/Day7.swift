//
//  Day7.swift
//  Advent of Code 2021
//
//  Created by Thomas Stidham on 1/8/22.
//

import Foundation

class Day7 {
	let consoleIO = ConsoleIO()
	
	func AlignCrabs(DataType: String) {
		
		let cb = CrabPositions()
		var positions: [Int]
		if DataType == "test" {
			positions = cb.TestData.sorted()
			consoleIO.writeMessage("\(positions)")
		}
		else {
			positions = cb.ProdData.sorted()
		}
		
		var sum = 0
		positions.forEach { c in sum += c }
		
		let average = Int(round(Double(sum) / Double(positions.count)))
		consoleIO.writeMessage("Sum \(sum), Count: \(positions.count) Ave \(Double(sum) / Double(positions.count)), \(average)")
		
		let median: Int
		if positions.count % 2 == 0 {
			// Even number of elements, pick middle two and average
			median = Int((positions[positions.count / 2] + positions[(positions.count / 2) - 1]) / 2)
		} else {
			// Odd number, pick middle element
			median = positions[Int(positions.count / 2)]
		}

		consoleIO.writeMessage("Median is: \(median)")
		
		var fuelUsedMedian: Int = 0, fuelUsedAve = 0
		var averageDistance: Int
		for i in positions {
			fuelUsedMedian += abs(i - median)
			averageDistance = abs(i - average)
			fuelUsedAve += ((averageDistance * averageDistance) + averageDistance) / 2
		}

		consoleIO.writeMessage("Amount of fuel used via median: \(fuelUsedMedian)")
		consoleIO.writeMessage("Amount of fuel used via average: \(fuelUsedAve)")

		var checkAveValues: [Int: Int] = [:]
		
		for checkValue in average - abs(average - median)...average + abs(average - median) {
			fuelUsedAve = 0
			for i in positions {
				averageDistance = abs(i - checkValue)
				fuelUsedAve += ((averageDistance * averageDistance) + averageDistance) / 2
			}
			checkAveValues.merge([checkValue: fuelUsedAve], uniquingKeysWith: {(current, _) in current })
			consoleIO.writeMessage("Amount of fuel used at value \(checkValue) via average: \(fuelUsedAve)")
		}
		let smallestValue = checkAveValues.min{ a, b in a.value < b.value }
		consoleIO.writeMessage("Smallest value \(String(describing: smallestValue?.value)) occurs at key \(String(describing: smallestValue?.key))")
	}
}
