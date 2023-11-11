//
//  PuzzleBoxGameMediator.swift
//  game2048
//
//  Created by sw on 2023/11/11.
//

protocol PuzzleBoxGameScoreObserverProtocol {
    
    mutating func plus(score: Int)
    mutating func minus(score: Int)
    
}
