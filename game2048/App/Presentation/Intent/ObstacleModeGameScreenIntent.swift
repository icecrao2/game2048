//
//  ObstacleModeGameScreenIntent.swift
//  game2048
//
//  Created by sw on 2023/10/16.
//

import Foundation


class ObstacleModeGameScreenIntent: GameScreenIntent {
    
    
    override func didTapResetButton() {
        if !canHandleEvent { return }
        
        model.reset()
        model.makeNewPuzzleBox()
        model.makeNewObstacleBox()
        model.refreshPuzzleBoxArray()
        
        model.saveGame()
        
        model.updateGameState()
    }
}
