//
//  Day5.swift
//  Advent of Code 2021
//
//  Created by Thomas Stidham on 1/6/22.
//

import Foundation

class Day5 {
	
	func Danger()
	{
		let vm = VentMapping()
		vm.GetVentData(dataType: "prod")
		vm.ProcessVentDataByLine(diagonal: false)
		vm.ProcessVentDataByLine(diagonal: true)
	}
}
