//
//  Positions.swift
//  Advent of Code 2021
//
//  Created by Thomas Stidham on 12/30/21.
//

import Foundation

public struct PositionList {
	var Direction: String
	var Movement: Int
}

class Positions {
	func GetPositions(dataType: String) -> [PositionList] {
		var rtn :[String]
		
		if dataType == "test"
		{
			rtn = testPostions
		}
		else {
			rtn = ReadPosition()
		}
		
		var movement = [PositionList]()
		
		for m in rtn {
			let s = m.split(separator: " ")
			movement.append(PositionList.init(Direction: String(s[0]), Movement: Int(s[1]) ?? 0))
		}
		
		return movement
	}
	
	public let testPostions = [
		"forward 5",
		"down 5",
		"forward 8",
		"up 3",
		"down 8",
		"forward 2"]
	
	private func ReadPosition() -> [String] {
		let filename = "/Users/thomasstidham/Documents/source/Advent of Code/AdventOfCode2021/Advent of Code 2021/DataFiles/Positions.txt"
		let data = try? String(contentsOfFile: filename)
		
		let lines = data?.split(separator: "\n")
		
		var entries: [String] = []
		
		if !lines!.isEmpty {
			for line in lines! {
				entries.append(String(line))
			}
		}
		
		return entries
	}
}
