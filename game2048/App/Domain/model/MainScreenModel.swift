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
        
        PuzzleBoxModel.map = currentMode.getMapSizeByTupleType()
    }
}
