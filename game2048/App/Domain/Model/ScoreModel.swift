//
//  ScoreModel.swift
//  game2048
//
//  Created by sw on 2023/11/11.
//

import Foundation


struct ScoreModel: PuzzleBoxGameScoreObserverProtocol {
   
    private(set) var currentScore: Int
    private(set) var topScore: Int
   
    private var coppiedCurrentScore: Int
    private var coppiedTopScore: Int
    
    mutating func plus(score: Int) {
        
        self.coppiedCurrentScore = self.currentScore
        self.coppiedTopScore = self.topScore

        self.currentScore += score
        
        if self.currentScore >= self.topScore {
            self.topScore = self.currentScore
        }
    }
    
    mutating func minus(score: Int) {
        
        if self.currentScore == self.topScore {
            self.topScore -= score
        }
        
        self.currentScore -= score   
    }
}
