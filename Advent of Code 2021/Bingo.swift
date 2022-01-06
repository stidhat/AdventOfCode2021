//
//  BingoCard.swift
//  Advent of Code 2021
//
//  Created by Thomas Stidham on 1/3/22.
//

import Foundation

class Bingo {
	let consoleIO = ConsoleIO()
	var DrawnNumbers: [Int]
	var Cards: [BingoCard]
	
	init(){
		DrawnNumbers = []
		Cards = []
	}
	
	/// Read the numbers drawn and bingo cards from chosen source
	/// - Parameter dataType: Source of data, test or prod
	public func ReadBingoData(dataType: String) {
		let data: String?
		
		if dataType == "test" {
			data = testData
		}
		else {
			let filename = "/Users/thomasstidham/Documents/source/Advent of Code/AdventOfCode2021/Advent of Code 2021/DataFiles/Bingo.txt"
			data = try? String(contentsOfFile: filename)
		}
		
		let lines = data?.split(separator: "\n", omittingEmptySubsequences: false)
		
		if (lines?.count == 0) {
			consoleIO.writeMessage("No data found in input")
			return
		}
		
		for n in lines![0].split(separator: ",") {
			DrawnNumbers.append(Int(n) ?? 0)
		}
		
		var l: Int = 1
		var rowNum = 1
		var newCard: BingoCard = BingoCard()
		var cardSetup = false
		
		while l < lines!.count {
			if lines![l].trimmingCharacters(in: NSCharacterSet.whitespaces).count == 0 {
				newCard = BingoCard()
				Cards.append(newCard)
				rowNum = 1
				cardSetup = false
			}
			else
			{
				var column = 0
				for n in lines![l].split(separator: " ") {
					switch rowNum {
					case 1:
						newCard.Row1[column] = Int(n) ?? 0
					case 2:
						newCard.Row2[column] = Int(n) ?? 0
					case 3:
						newCard.Row3[column] = Int(n) ?? 0
					case 4:
						newCard.Row4[column] = Int(n) ?? 0
					case 5:
						newCard.Row5[column] = Int(n) ?? 0
					default:
						newCard.Row1[column] = 0
					}
					
					column += 1
					
					if (rowNum == 5 && column == 5) {
						cardSetup = true
					}
				}
				
				rowNum += 1
			}
			l += 1
		}
		if !cardSetup {
			Cards.removeLast()
		}
	}
	
	public func MarkCards(pick: Int) {
		for card in Cards {
			if card.Row1.contains(pick) {
				card.Row1Marked[card.Row1.firstIndex(of: pick)!] = true
			}
			else if card.Row2.contains(pick) {
				card.Row2Marked[card.Row2.firstIndex(of: pick)!] = true
			}
			else if card.Row3.contains(pick) {
				card.Row3Marked[card.Row3.firstIndex(of: pick)!] = true
			}
			else if card.Row4.contains(pick) {
				card.Row4Marked[card.Row4.firstIndex(of: pick)!] = true
			}
			else if card.Row5.contains(pick) {
				card.Row5Marked[card.Row5.firstIndex(of: pick)!] = true
			}
		}
	}
	
	public func ResetCardMarks() {
		for card in Cards {
			card.ResetMarks()
		}
	}
	
	public func CheckForWinner() -> BingoCard? {
		var rtn: BingoCard? = nil
		var winner = false
		//var i = 0
		
		// Mark all winning cards
		for card in Cards {
			if !card.Winner {
				winner = false
				
				// First check each row for no marked values are false
				if !card.Row1Marked.contains(false) {
					winner = true
				}
				else if !card.Row2Marked.contains(false) {
					winner = true
				}
				else if !card.Row3Marked.contains(false) {
					winner = true
				}
				else if !card.Row4Marked.contains(false) {
					winner = true
				}
				else if !card.Row5Marked.contains(false) {
					winner = true
				}
				
				// Did not find winnig row, check columns
				if !winner {
					for i in 0...4 {
						if card.Row1Marked[i] == true &&
							card.Row2Marked[i] == true &&
							card.Row3Marked[i] == true &&
							card.Row4Marked[i] == true &&
							card.Row5Marked[i] == true {
							winner = true
						}
					}
				}
			
				if winner {
					card.Winner = true
					rtn = card
				}
			}
		}
		
		return rtn
	}
	
	
	let testData = """
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
"""
}

class BingoCard: CustomStringConvertible {
	init() {
		Row1 = [0, 0, 0, 0, 0]
		Row1Marked = [false, false, false, false, false]
		Row2 = [0, 0, 0, 0, 0]
		Row2Marked = [false, false, false, false, false]
		Row3 = [0, 0, 0, 0, 0]
		Row3Marked = [false, false, false, false, false]
		Row4 = [0, 0, 0, 0, 0]
		Row4Marked = [false, false, false, false, false]
		Row5 = [0, 0, 0, 0, 0]
		Row5Marked = [false, false, false, false, false]
	}
	
	public var description: String {
		var printedCard = ""
		printedCard = printRow(row: Row1, marks: Row1Marked)
		printedCard += "\n" + printRow(row: Row2, marks: Row2Marked)
		printedCard += "\n" + printRow(row: Row3, marks: Row3Marked)
		printedCard += "\n" + printRow(row: Row4, marks: Row4Marked)
		printedCard += "\n" + printRow(row: Row5, marks: Row5Marked)
		
		return printedCard
	}
	
	private func printRow(row: [Int], marks: [Bool]) -> String {
		var printedRow = ""
		for i in 0...4 {
			printedRow += (row[i] < 10 ? " " : "") + String(row[i]) + (marks[i] ? "* " : "  ")
		}
		return printedRow
	}
	
	func ResetMarks() {
		Row1Marked = [false, false, false, false, false]
		Row2Marked = [false, false, false, false, false]
		Row3Marked = [false, false, false, false, false]
		Row4Marked = [false, false, false, false, false]
		Row5Marked = [false, false, false, false, false]
		Winner = false
	}
	
	
	// How I could have done it
	//	var Card: [[Int]] = [
	//		[0, 0, 0, 0, 0],
	//		[0, 0, 0, 0, 0],
	//		[0, 0, 0, 0, 0],
	//		[0, 0, 0, 0, 0],
	//		[0, 0, 0, 0, 0]]
	
	// How I should have done it
	//	var Card2: [[(Int, Bool)]] = [
	//		[(0, false), (0, false), (0, false), (0, false), (0, false)],
	//		[(0, false), (0, false), (0, false), (0, false), (0, false)],
	//		[(0, false), (0, false), (0, false), (0, false), (0, false)],
	//		[(0, false), (0, false), (0, false), (0, false), (0, false)],
	//		[(0, false), (0, false), (0, false), (0, false), (0, false)]
	//	]
	
	var Winner = false
	var Row1: [Int]
	var Row1Marked: [Bool]
	var Row2: [Int]
	var Row2Marked: [Bool]
	var Row3: [Int]
	var Row3Marked: [Bool]
	var Row4: [Int]
	var Row4Marked: [Bool]
	var Row5: [Int]
	var Row5Marked: [Bool]
}
