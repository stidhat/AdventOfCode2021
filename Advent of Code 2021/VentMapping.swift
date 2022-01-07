//
//  VentMapping.swift
//  Advent of Code 2021
//
//  Created by Thomas Stidham on 1/6/22.
//

import Foundation

class VentMapping {
	let consoleIO = ConsoleIO()
	var VentData: [Line]
	
	init() {
		VentData = []
	}
	
	func GetVentData(dataType: String) {
		var lines: [String.SubSequence]
		if (dataType == "test")
		{
			lines = TestData.split(separator: "\n")
		}
		else
		{
			// read from file
			let filename = "/Users/thomasstidham/Documents/source/Advent of Code/AdventOfCode2021/Advent of Code 2021/DataFiles/VentData.txt"
			let data = try? String(contentsOfFile: filename)
			lines = data!.split(separator: "\n")
		}
		
		var line: Line
		var break1: Substring.Index
		var break2: Substring.Index
		var point1x: Int?, point1y: Int?, point2x: Int?, point2y: Int?
		
		for l in lines
		{
			if !l.isEmpty {
				break2 = l.index(before: l.firstIndex(of: ",")!)
				point1x = Int(l[...break2])
				
				break1 = l.index(break2, offsetBy: 2)
				break2 = l.index(before: l.firstIndex(of: " ")!)
				point1y = Int(l[break1...break2])
				
				break1 = l.index(after: l.lastIndex(of: " ")!)
				break2 = l.index(before: l.lastIndex(of: ",")!)
				point2x = Int(l[break1...break2])
				
				break1 = l.index(break2, offsetBy: 2)
				break2 = l.index(before: l.endIndex)
				point2y = Int(l[break1...break2])
				
				line = Line(Point1: (point1x!, point1y!), Point2: (point2x!,point2y!))
				VentData.append(line)
			}
		}
		
	}
	
	func ProcessVentDataByLine(diagonal: Bool) {
		// Create and initialize the grid
		var m = 0
		for line in VentData {
			if m < line.Point1.x1 {
				m = line.Point1.x1
			}
			if m < line.Point1.y1 {
				m = line.Point1.y1
			}
			if m < line.Point2.x2 {
				m = line.Point2.x2
			}
			if m < line.Point2.y2 {
				m = line.Point2.y2
			}
		}
		
		var grid = Array(repeating: Array(repeating: 0, count: m+1), count: m+1)
		
		for line in VentData {
			if (line.Point1.x1 == line.Point2.x2) {
				let startPoint = line.Point1.y1 <= line.Point2.y2 ? line.Point1.y1 : line.Point2.y2
				let endPoint = line.Point1.y1 < line.Point2.y2 ? line.Point2.y2 : line.Point1.y1
				
				for y in startPoint...endPoint {
					grid[y][line.Point1.x1] += 1
				}
			}
			else if (line.Point1.y1 == line.Point2.y2) {
				let startPoint = line.Point1.x1 <= line.Point2.x2 ? line.Point1.x1 : line.Point2.x2
				let endPoint = line.Point1.x1 < line.Point2.x2 ? line.Point2.x2 : line.Point1.x1
				
				for x in startPoint...endPoint {
					grid[line.Point1.y1][x] += 1
				}
			}
			else if diagonal {
				// Diagnonal line
				var slopey = line.Point2.y2 - line.Point1.y1
				var slopex = line.Point2.x2 - line.Point1.x1
				
				
				let tempy = slopey / abs(slopex)
				slopex = slopex / abs(slopey)
				slopey = tempy
				
				var x: Int, y: Int
				x = line.Point1.x1
				y = line.Point1.y1
				grid[y][x] += 1
				while x != line.Point2.x2 && y != line.Point2.y2 {
					y += slopey
					x += slopex
					grid[y][x] += 1
				}
			}
		}
		
		
		var dangerCount = 0
		
		for gridLine in grid {
			//gridLine.filter{$0 >= 2}.count
			gridLine.forEach { x in if x >= 2 {dangerCount += 1}}
			
			if gridLine.count < 20 {
				for point in gridLine {
					print((point == 0 ? " . " : (point < 10 ? " " : "") + String(point) + " "), terminator: "" )
				}
				print()
			}
		}
		consoleIO.writeMessage("Number of points to avoid: \(dangerCount)")
	}
	
	struct Line {
		var Point1: (x1: Int, y1: Int)
		var Point2: (x2: Int, y2:Int)
	}
	
	let TestData = """
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
"""
}
