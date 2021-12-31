//
//  Day2.swift
//  Advent of Code 2021
//
//  Created by Thomas Stidham on 12/30/21.
//

import Foundation

class Day2 {
	let position = Positions()
	let movements: [PositionList]
	
	init() {
		movements = position.GetPositions(dataType: "prod")
	}
	
	func FindPosition() {
		var horizontal = 0
		var depth = 0
		
		for m in movements {
			switch m.Direction {
			case "forward":
				horizontal += m.Movement
			case "up":
				depth -= m.Movement
			case "down":
				depth += m.Movement
			default:
				print("New value error: \(m.Direction), \(m.Movement)")
			}
		}
		print("First exercise")
		print("Horizontal: \(horizontal), Depth: \(depth)")
		print("Calculated: \(horizontal * depth)")
	}
	
	func FindByAim() {
		var horizontal = 0
		var aim = 0
		var depth = 0
		
		for m in movements {
			switch m.Direction {
			case "forward":
				horizontal += m.Movement
				depth += m.Movement * aim
			case "up":
				aim -= m.Movement
			case "down":
				aim += m.Movement
			default:
				print("New value error: \(m.Direction), \(m.Movement)")
			}
		}
		print("Second exercise")
		print("Horizontal: \(horizontal), Depth: \(depth)")
		print("Calculated: \(horizontal * depth)")
	}
}
