//
//  Day1.swift
//  Advent of Code 2021
//
//  Created by Thomas Stidham on 12/29/21.
//

import Foundation

class Day1 {
    let consoleIO = ConsoleIO()
	
    func SonarSweep () {
		var increases = 0
		
		let dm = DepthMeasurement()
		
		for i in 1..<dm.depths.count {
			if dm.depths[i] > dm.depths[i - 1]
			{
				increases += 1
			}
		}

		consoleIO.writeMessage("Number of increases \(increases)")
	}
	
	func SonarSweepWindow() {
		var increases = 0
		
		let dm = DepthMeasurement()
		let depths = dm.depths
		
		for i in 0..<depths.count-3 {
			if depths[i] + depths[i+1] + depths[i+2] <
				depths[i+1] + depths[i+2] + depths[i+3]
			{
				increases += 1
			}
		}
		consoleIO.writeMessage("Number of window increases \(increases)")
	}
}
