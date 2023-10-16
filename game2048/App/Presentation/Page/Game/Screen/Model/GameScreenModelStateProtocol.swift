//
//  GameScreenModelStateProtocol.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation


protocol GameScreenModelStateProtocol {
    
    var currentScore: Int { get }
    var topScore: Int { get }
    
    var gameStatus: GameStatus { get }
//    var puzzleBoxArray: [[PuzzleBoxModel?]] { get }
    
    var puzzleBoxes: [PuzzleBoxModel] { get }
}

protocol GameScreenModelActionProtocol {
    
    func loadGame()
    func saveGame()
    
    func updateGameState()
    
    func undoLastChange()
    func reset()
    
    func canSwipe(to direction: Direction) -> Bool
    
    func mergeToRight()
    
    func moveToRight()
    
    func mergeToLeft()
    
    func moveToLeft()
    
    func mergetToDown()
    
    
    func moveToDown()
    
    func mergetToUp()
    
    func moveToUp()
    
    func increaseCurrentScore(plus score: Int)
    
    func setTopScore(score: Int)
    
    func makeNewPuzzleBox()
    
    func makeNewObstacleBox()
    
    func refreshPuzzleBoxArray()
    
    func rememberCurrentPuzzleBoxArray()
}
