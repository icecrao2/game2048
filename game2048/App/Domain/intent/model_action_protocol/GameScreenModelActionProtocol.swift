//
//  GameScreenModelActionProtocol.swift
//  game2048
//
//  Created by sw on 2023/11/05.
//

import Foundation

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
