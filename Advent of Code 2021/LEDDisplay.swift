//
//  LEDDisplay.swift
//  Advent of Code 2021
//
//  Created by Thomas Stidham on 1/21/22.
//

import Foundation

class LEDDisplay {
let TestData = [
	"be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe",
	"edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc",
	"fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg",
	"fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb",
	"aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea",
	"fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb",
	"dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe",
	"bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef",
	"egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb",
	"gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce"
	]
	
	struct reading {
		var signal: [String]
		var pattern: [String]
	}
	var readings: [reading]
	
	init() {
		 readings = []
	}
	
	func GetLoggedDisplay (DataType: String) {
		var importData: [String]
		
		if (DataType == "test") {
			importData = TestData
		} else {
			// read from file
			importData = []
			let filename = "/Users/thomasstidham/Documents/source/Advent of Code/AdventOfCode2021/Advent of Code 2021/DataFiles/LEDSegments.txt"
			let data = try? String(contentsOfFile: filename)
			for line in data!.split(separator: "\n") {
				importData.append(String(line))
			}
		}
		
//		var signals: [String]
//		var patterns: [String]
//		var readings: [
//		"signals": [String],
//		"patterns": [String]
//		]
		
		for line in importData {
			let splitLine = line.split(separator: "|")
			
			var newReading = reading(signal: [], pattern: [])
			
			for element in splitLine[0].split(separator: " ") {
				newReading.signal.append(String(element))
			}
			
			for element in splitLine[1].split(separator: " ") {
				newReading.pattern.append(String(element))
			}
			
			readings.append(newReading)
		}
	}
	
	func CountUniqueDigits() -> Int
	{
		/*
		1 - 2 segments
		4 - 4 segments
		7 - 3 segments
		8 - 7 segments
		*/
		
		var lengthOfPattern: Int
		var uniqueDigit = 0
		
		for line in readings {
			for p in line.pattern {
				lengthOfPattern = p.lengthOfBytes(using: String.Encoding.ascii)
				if ([2,4,3,7].contains(lengthOfPattern)) {
					uniqueDigit += 1
				}
			}
		}
		return uniqueDigit
	}
	
	func DigitDecode ()
	{
		/*
		known - 1 4 7 8
		1 and 7 gives 'a' and (c,f)
		compare 4 with 5 segments ones, look for (c,f) match that is 3 subtract 4 and 'a' gives 'g'
		combine 3 and 4, this is the pattern for 9, difference between 3 and 9 yeilds 'b'
		known - 1 3 4 7 8 9 'a' 'b' 'g' (c,f)
		Of remaining 6 segments one with (c,f) is 0, subtract 9 yeilds 'e'
		known - 0 1 3 4 7 8 9 'a' 'b' 'e' 'g' (c,f)
		The last 6 segment is 6, subtract 0 yeilds d
		known - 0 1 3 4 6 7 8 9 'a' 'b' 'd' 'e' 'g' (c,f)
		Of remaining 5 segment one with 'e' is 2, this will identify c and f
		The other one is 5
		known - 0 1 2 3 4 5 6 7 8 9 'a' 'b' 'c' 'd' 'e' 'f' 'g'
		
		10 element string array for the numbers
		7 element char array for segments
		
		*/
		var segments: [Character] = []
		for _ in 0...7
		{
			segments.append(contentsOf: "")
		}
		
		var numbers: [String] = []
		for _ in 0...9
		{
			numbers.append("")
		}
		
		
	}
}

