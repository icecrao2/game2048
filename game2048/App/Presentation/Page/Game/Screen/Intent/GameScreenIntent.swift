//
//  GameScreenIntent.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation
import SwiftUI

class GameScreenIntent {
    
    private var model: GameScreenModelActionProtocol
    
    private var currentPosition: CGPoint = .zero
    private var startDragPosition: CGPoint = .zero
    private var dragDirection: Direction = .none
    
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
    
    func didDragChange(_ gesture: DragGesture.Value) {
        
        if dragDirection == .none {
            // 초기 드래그 시작 위치를 설정
            startDragPosition = gesture.location
        }
        
        // 현재 위치 업데이트
        currentPosition = gesture.location
        
        // 드래그 방향 결정
        let horizontalDistance = currentPosition.x - startDragPosition.x
        let verticalDistance = currentPosition.y - startDragPosition.y
        
        if abs(horizontalDistance) > abs(verticalDistance) {
            // 수평 이동
            dragDirection = horizontalDistance > 0 ? .right : .left
        } else {
            // 수직 이동
            dragDirection = verticalDistance > 0 ? .down : .up
        }
    }
    
    func didDragEnd() {
        
        switch dragDirection {
        case .none:
            break
        case .up:
            model.moveToUp()
        case .down:
            model.moveToDown()
        case .left:
            model.moveToLeft()
        case .right:
            model.moveToRight()
        }
        model.refreshPuzzleBoxArray()
        
        
        startDragPosition = .zero
        dragDirection = .none
    }
}
