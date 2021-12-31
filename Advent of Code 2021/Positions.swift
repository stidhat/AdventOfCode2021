//
//  Positions.swift
//  Advent of Code 2021
//
//  Created by Thomas Stidham on 12/30/21.
//

import Foundation

class Positions {
	
	func GetPositions(dataType: String) -> [String] {
		var rtn :[String]
		
		if dataType == "test"
		{
			rtn = testPostions
		}
		else {
			rtn = ["test", "test 2"]
		}
		
		return rtn
	}
	
	public let testPostions = [
		"forward 5",
		"down 5",
		"forward 8",
		"up 3",
		"down 8",
		"forward 2"]
	
	private func ReadPosition () {
		let positionFile = FileHandle.init(forReadingAtPath: "Positions.txt")
		let data = positionFile?.readDataToEndOfFile()
		
	}
}
