//
//  Day4.swift
//  Advent of Code 2021
//
//  Created by Thomas Stidham on 1/3/22.
//

import Foundation

class Day4 {
	let consoleIO = ConsoleIO()
	let dataType = "prod"
	let bingo = Bingo()
	
	init(){
		bingo.ReadBingoData(dataType: dataType)
	}
	
	func PlayBingo() {
		bingo.ResetCardMarks()
		
		// Mark the first five numbers, cannot have a row or column
		// all marked until at least 5 are drawn
		for num in bingo.DrawnNumbers[0...4] {
			bingo.MarkCards(pick: num)
		}
		
		var c = 5
		var winner: BingoCard? = nil
		
		// Check for winner, if none, draw next number
		repeat {
			bingo.MarkCards(pick: bingo.DrawnNumbers[c])
			winner = bingo.CheckForWinner()
			
			c += 1
		} while winner == nil && c < bingo.DrawnNumbers.count
		
		if winner == nil {
			consoleIO.writeMessage("No winner in this group")
		}
		else {
			consoleIO.writeMessage("Winning card is:\n\(winner!)")
			consoleIO.writeMessage("Winning number was \(bingo.DrawnNumbers[c-1]) at position \(c-1)")
			
			var score = 0
			for i in 0...4 {
				if !winner!.Row1Marked[i] {
					score += winner!.Row1[i]
				}
				if !winner!.Row2Marked[i] {
					score += winner!.Row2[i]
				}
				if !winner!.Row3Marked[i] {
					score += winner!.Row3[i]
				}
				if !winner!.Row4Marked[i] {
					score += winner!.Row4[i]
				}
				if !winner!.Row5Marked[i] {
					score += winner!.Row5[i]
				}
			}
			score *= bingo.DrawnNumbers[c-1]
			consoleIO.writeMessage("Score of card is: \(score)")
		}
		
		
	}

	func LoseBingo() {
		bingo.ResetCardMarks()
		
		for num in bingo.DrawnNumbers[0...4] {
			bingo.MarkCards(pick: num)
		}
		
		var c = 5
		var loseCount = 0
		var loser: BingoCard? = nil
		
		// Check for winner, if none, draw next number
		repeat {
			bingo.MarkCards(pick: bingo.DrawnNumbers[c])
			loser = bingo.CheckForWinner()
			
			loseCount = bingo.Cards.filter { $0.Winner == true }.count

			c += 1
		} while loseCount < bingo.Cards.count && c < bingo.DrawnNumbers.count

		if loser != nil {
			consoleIO.writeMessage("Losing card is:\n\(loser!)")
			
			var score = 0
			for i in 0...4 {
				if !loser!.Row1Marked[i] {
					score += loser!.Row1[i]
				}
				if !loser!.Row2Marked[i] {
					score += loser!.Row2[i]
				}
				if !loser!.Row3Marked[i] {
					score += loser!.Row3[i]
				}
				if !loser!.Row4Marked[i] {
					score += loser!.Row4[i]
				}
				if !loser!.Row5Marked[i] {
					score += loser!.Row5[i]
				}
			}
			score *= bingo.DrawnNumbers[c-1]
			consoleIO.writeMessage("Score of card is: \(score)")
		}
		else {
			consoleIO.writeMessage("No losing cards?!?")
		}
	}
}


