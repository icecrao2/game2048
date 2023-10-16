//
//  MainScreenModel.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation


class MainScreenModel: ObservableObject, MainScreenModelStateProtocol {
    
    @Published private(set) var currentMode: GameModeEnum = .ThreeOnThree
}


extension MainScreenModel: MainScreenModelActionProtocol {
    
    func changeModeTo(next: Bool) {
        currentMode = next ? currentMode.next() : currentMode.previous()
    }
    
    func applyCurrentMode() {
        
        switch currentMode {
        case .ThreeOnThree:
            PuzzleBoxModel.map = (3, 3)
        case .FourOnFour:
            PuzzleBoxModel.map = (4, 4)
        case .FiveOnFive:
            PuzzleBoxModel.map = (5, 5)
        case .SixOnSix:
            PuzzleBoxModel.map = (6, 6)
        case .EightOnEight:
            PuzzleBoxModel.map = (8, 8)
        }
        
        
    }
}
