//
//  DiagnosticReport.swift
//  Advent of Code 2021
//
//  Created by Thomas Stidham on 1/1/22.
//

import Foundation

class DiagnosticReport {
	func GetDiagnostics(dataType: String) -> [UInt16] {
		var diags: [UInt16] = []
		
		if (dataType == "test")
		{
			diags = TestDiagnostics;
		}
		else
		{
			diags = ReadDiagnostics()
		}
		
		return diags;
	}
	
	func GetDiagnosticsString(dataType: String) -> [String] {
		var diags: [String]
		if (dataType == "test") {
			diags = TestDiagnosticsString
		}
		else {
			diags = ReadDiagnosticsString()
		}
		return diags
	}
	
	let TestDiagnostics: [UInt16] = [
		0b00100,
		0b11110,
		0b10110,
		0b10111,
		0b10101,
		0b01111,
		0b00111,
		0b11100,
		0b10000,
		0b11001,
		0b00010,
		0b01010
	]
	
	let TestDiagnosticsString: [String] = [
		"00100",
		"11110",
		"10110",
		"10111",
		"10101",
		"01111",
		"00111",
		"11100",
		"10000",
		"11001",
		"00010",
		"01010"
	]
	
	private func ReadDiagnostics() -> [UInt16] {
		let filename = "/Users/thomasstidham/Documents/source/Advent of Code/AdventOfCode2021/Advent of Code 2021/DataFiles/DiagnosticReport.txt"
		let data = try? String(contentsOfFile: filename)
		
		let lines = data?.split(separator: "\n")
		
		var entries: [UInt16] = []
		
		if !lines!.isEmpty {
			for line in lines! {
				let t = UInt16(strtoul(String(line), nil, 2))
				
				if (line.count > 0) {
					entries.append(t)
				}
			}
		}
		
		return entries
	}
	
	private func ReadDiagnosticsString() -> [String] {
		let filename = "/Users/thomasstidham/Documents/source/Advent of Code/AdventOfCode2021/Advent of Code 2021/DataFiles/DiagnosticReport.txt"
		let data = try? String(contentsOfFile: filename)
		
		let lines = data?.split(separator: "\n")
		
		var entries: [String] = []
		
		if !lines!.isEmpty {
			for line in lines! {
				if line.count > 0 {
					entries.append(String(line))
				}
			}
		}
		
		return entries
	}
}
