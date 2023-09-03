//
//  GameScreenModel.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation
import SwiftUI

class GameScreenModel: ObservableObject, GameScreenModelStateProtocol {
 
    @Published private(set) var currentScore: Int = 0
    @Published private(set) var topScore: Int = 0
    
    @Published private(set) var puzzleArray: [[Int]] = [[0]]
    
}

extension GameScreenModel: GameScreenModelActionProtocol {
    
}
