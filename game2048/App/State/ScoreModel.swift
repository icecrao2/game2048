//
//  ScoreModel.swift
//  game2048
//
//  Created by sw on 2023/11/05.
//

import Foundation


class ScoreModel {
    
    var currentScore: Int
    var topScore: Int
    
    var coppiedCurrentScore: Int
    var coppiedTopScore: Int
    
    init(currentScore: Int, topScore: Int, coppiedCurrentScore: Int, coppiedTopScore: Int) {
        self.currentScore = currentScore
        self.topScore = topScore
        self.coppiedCurrentScore = coppiedCurrentScore
        self.coppiedTopScore = coppiedTopScore
    }
    
    func updateScore(addedScore score: Int) {
        
        backupScore()
        
        increaseCurrentScore(plus: score)
        
        updateTopScore()
    }
    
    func resetScoreToPreviousState() {
        self.currentScore = self.coppiedCurrentScore
        self.topScore = self.coppiedTopScore
    }
    
    private func backupScore() {
        coppiedCurrentScore = currentScore
        coppiedTopScore = topScore
    }
    
    private func increaseCurrentScore(plus score: Int) {
        self.currentScore += score
    }
    
    private func updateTopScore() {
        if currentScore >= topScore {
            setTopScore(score: currentScore)
        }
    }
    
    private func setTopScore(score: Int) {
        self.topScore = score
    }
    
}
