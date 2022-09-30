//
//  Day8.swift
//  Advent of Code 2021
//
//  Created by Thomas Stidham on 1/21/22.
//

import Foundation

class Day8 {
	let consoleIO = ConsoleIO()
	
	func BasicCount() {
		let leds = LEDDisplay()
		leds.GetLoggedDisplay(DataType: "test")
		consoleIO.writeMessage("Unique digits count: \(leds.CountUniqueDigits())")
	}
}
