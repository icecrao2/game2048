//
//  GameScreenIntent.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation

class GameScreenIntent {
    
    
    
    private weak var navigationManager: NavigationManager? = NavigationManager.shared
    
    var model: GameScreenModelActionProtocol
    
    private var currentPosition: CGPoint = .zero
    private var startDragPosition: CGPoint = .zero
    private var dragDirection: Direction = .none
    
    var canHandleEvent: Bool = true
    
    init(model: GameScreenModelActionProtocol) {
        self.model = model
    }
    
    private func readyToNextStage() {
        model.makeNewPuzzleBox()
        model.refreshPuzzleBoxArray()
    }
    
    func didTapResetButton() {
        if !canHandleEvent { return }
        
        model.reset()
        model.makeNewPuzzleBox()
        model.refreshPuzzleBoxArray()
        
        model.saveGame()
        
        model.updateGameState()
    }
}




extension GameScreenIntent: GameScreenIntentProtocol {
    
    func viewOnAppear() {
        model.loadGame()
        
        model.updateGameState()
    }
    
    func gameViewOnAppear() {
        
        model.makeNewPuzzleBox()
        model.refreshPuzzleBoxArray()
    }
    
    
    func viewOnDisappear() {
       
    }
    
    
    
    func didDragChange(_ gesture: CGPoint) {
        
        if dragDirection == .none {
            startDragPosition = gesture
        }
        
        currentPosition = gesture
        
        let horizontalDistance = currentPosition.x - startDragPosition.x
        let verticalDistance = currentPosition.y - startDragPosition.y
        
        if abs(horizontalDistance) > abs(verticalDistance) {
            dragDirection = horizontalDistance > 0 ? .right : .left
        } else {
            dragDirection = verticalDistance > 0 ? .down : .up
        }
    }
    
    func didDragEnd() {
        
        if !model.canSwipe(to: dragDirection) { return }
        
        if !canHandleEvent { return }
        
        canHandleEvent = false
        
        switch dragDirection {
        case .none:
            canHandleEvent = true
            return
        case .up:
            model.rememberCurrentPuzzleBoxArray()
            model.mergetToUp()
            model.moveToUp()
        case .down:
            model.rememberCurrentPuzzleBoxArray()
            model.mergetToDown()
            model.moveToDown()
        case .left:
            model.rememberCurrentPuzzleBoxArray()
            model.mergeToLeft()
            model.moveToLeft()
        case .right:
            model.rememberCurrentPuzzleBoxArray()
            model.mergeToRight()
            model.moveToRight()
        }
        model.refreshPuzzleBoxArray()
        
        startDragPosition = .zero
        dragDirection = .none
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.readyToNextStage()
            self.canHandleEvent = true
            self.model.saveGame()
            
            self.model.updateGameState()
        }
    }
    
    func didTapHomeButton() {
        if !canHandleEvent { return }
        
        navigationManager?.backToRoot()
        
        AppStoreReviewManager.requestReviewIfAppropriate()
    }
    
    func didTapUndoButton() {
        if !canHandleEvent { return }
        
        model.undoLastChange()
        model.refreshPuzzleBoxArray()
        model.saveGame()
        model.updateGameState()
    }
}
