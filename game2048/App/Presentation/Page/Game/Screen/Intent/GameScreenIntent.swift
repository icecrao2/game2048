//
//  GameScreenIntent.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation


class GameScreenIntent {
    
    private var model: GameScreenModelActionProtocol
    
    init(model: GameScreenModelActionProtocol) {
        self.model = model
    }
}


extension GameScreenIntent: GameScreenIntentProtocol {
    
    
    func viewOnAppear() {
        
    }
    
    func gameViewOnAppear() {
        
        model.makeNewPuzzleBox()
        model.refreshPuzzleBoxArray()
    }
    
    func test() {
        
        model.moveToRight()
        model.refreshPuzzleBoxArray()
    }
    
}
