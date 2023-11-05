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
    var gameStatus: GamePhaseEnum { get }
    var puzzleBoxes: [PuzzleBoxModel] { get }
}
