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
    
    @Published private(set) var puzzleBoxArray: [[PuzzleBoxModel?]]

    private var scoreArray: [[Int]] {
        puzzleBoxArray.map { row in
            return row.map { box in
                box?.score ?? 0
            }
        }
    }
    
    init() {
        self.currentScore = 0
        self.topScore = 0
        self.puzzleBoxArray = [
            [nil, nil, nil, nil],
            [nil, nil, nil, nil],
            [nil, nil, nil, nil],
            [nil, nil, nil, nil],
        ]
    }
    
    init(currentScore: Int, topScore: Int, puzzleBoxArray: [[PuzzleBoxModel?]]) {
        self.currentScore = currentScore
        self.topScore = topScore
        self.puzzleBoxArray = puzzleBoxArray
    }
    
    
/* x = [1][0]
   0 1 2 3
 0
 1 x
 2
 3
*/
    
    
}

extension GameScreenModel: GameScreenModelActionProtocol {
    
    
    
    func mergeToRight() {
        for outIndex in 0..<puzzleBoxArray.count {
            
            outLoop: for index in (1..<puzzleBoxArray[outIndex].count).reversed() {
                
                guard let base = puzzleBoxArray[outIndex][index] else {
                    continue
                }
                
                for j in (0..<index).reversed() {
                    
                    guard let approacher = puzzleBoxArray[outIndex][j] else {
                        continue
                    }
                    
                    if approacher.getScore() == base.getScore() {
                        
                        puzzleBoxArray[outIndex][j]?.move(to: base.getLocation())
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.puzzleBoxArray[outIndex][index] = self.puzzleBoxArray[outIndex][j]
                            self.puzzleBoxArray[outIndex][j] = nil
                            self.puzzleBoxArray[outIndex][index]?.increase()
                            
                        }
                        break outLoop
                    }
                }
            }
        }
    }
    
    
    func moveToRight() {
        for outIndex in 0..<puzzleBoxArray.count {
            
            for index in (0..<puzzleBoxArray[outIndex].count).reversed() {
                
                if puzzleBoxArray[outIndex][index] != nil { continue }
                
                for j in (0..<index).reversed() {
                       
                    guard let approacher = puzzleBoxArray[outIndex][j] else {
                        continue
                    }
                    puzzleBoxArray[outIndex][index] = approacher
                    puzzleBoxArray[outIndex][j] = nil
                    
                    break
                }
            }
        }
    }
    
    
    
    func moveToLeft() {
        
    }
    
    func moveToUp() {
        
    }
    
    func moveToDown() {
        
    }
    
    func increaseCurrentScore(plus score: Int) {
        
    }
    
    func setTopScore(score: Int) {
        
    }
    
    func makeNewPuzzleBox() {
    }
    
    func refreshPuzzleBoxArray() {
        
    }
}
