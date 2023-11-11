//
//  GameSaver.swift
//  game2048
//
//  Created by sw on 2023/09/10.
//

import Foundation


struct GameSaverUserDefaultDTO: Codable {
    
    let topScore: Int
    let currentScore: Int
    let puzzleBoxArray: [[PuzzleBoxModel?]]
}

