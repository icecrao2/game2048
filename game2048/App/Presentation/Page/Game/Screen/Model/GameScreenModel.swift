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
    
    var puzzleBoxes: [PuzzleBoxModel] {
        
        var result: [PuzzleBoxModel] = []
        
        for i in 0..<puzzleBoxArray.count {
            for j in 0..<puzzleBoxArray[i].count {
                
                guard let box = puzzleBoxArray[i][j] else {
                    continue
                }
                result.append(box)
            }
        }
        
        return result
    }
    
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
            [nil, nil, nil, nil]
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
                        
                        self.puzzleBoxArray[outIndex][index] = self.puzzleBoxArray[outIndex][j]
                        self.puzzleBoxArray[outIndex][j] = nil
                        self.puzzleBoxArray[outIndex][index]?.increase()

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
    
    
    func mergeToLeft() {
        for outIndex in 0..<puzzleBoxArray.count {
            
            outLoop: for index in 0..<(puzzleBoxArray[outIndex].count - 1) {
                
                guard let base = puzzleBoxArray[outIndex][index] else {
                    continue
                }
                
                for j in (index + 1)...puzzleBoxArray[outIndex].count {
                    
                    guard let approacher = puzzleBoxArray[outIndex][j] else {
                        continue
                    }
                    
                    if approacher.getScore() == base.getScore() {
                        
                        puzzleBoxArray[outIndex][j]?.move(to: base.getLocation())
                        
                        self.puzzleBoxArray[outIndex][index] = self.puzzleBoxArray[outIndex][j]
                        self.puzzleBoxArray[outIndex][j] = nil
                        self.puzzleBoxArray[outIndex][index]?.increase()
                            
                        
                        break outLoop
                    }
                }
            }
        }
    }
    
    func moveToLeft() {
        for outIndex in 0..<puzzleBoxArray.count {
            
            for index in (0..<puzzleBoxArray[outIndex].count) {
                
                if puzzleBoxArray[outIndex][index] != nil { continue }
                
                for j in index..<puzzleBoxArray[outIndex].count {
                       
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
    
    func mergetToDown() {
        for outIndex in 0..<puzzleBoxArray[0].count {
            
            outLoop: for index in (1..<puzzleBoxArray.count).reversed() {
                
                guard let base = puzzleBoxArray[index][outIndex] else {
                    continue
                }
                
                for j in (0..<index).reversed() {
                    
                    guard let approacher = puzzleBoxArray[j][outIndex] else {
                        continue
                    }
                    
                    if approacher.getScore() == base.getScore() {
                        
                        puzzleBoxArray[j][outIndex]?.move(to: base.getLocation())
                        
                        self.puzzleBoxArray[index][outIndex] = self.puzzleBoxArray[j][outIndex]
                        self.puzzleBoxArray[j][outIndex] = nil
                        self.puzzleBoxArray[index][outIndex]?.increase()
                        
                        
                        break outLoop
                    }
                }
            }
        }
    }
    
    
    func moveToDown() {
        for outIndex in 0..<puzzleBoxArray[0].count {
            
            for index in (0..<puzzleBoxArray.count).reversed() {
                
                if puzzleBoxArray[index][outIndex] != nil { continue }
                
                for j in (0..<index).reversed() {
                       
                    guard let approacher = puzzleBoxArray[j][outIndex] else {
                        continue
                    }
                    puzzleBoxArray[index][outIndex] = approacher
                    puzzleBoxArray[j][outIndex] = nil
                    
                    break
                }
            }
        }
    }
    
    func mergetToUp() {
        for outIndex in 0..<puzzleBoxArray[0].count {
            
            outLoop: for index in 0..<(puzzleBoxArray.count - 1) {
                
                guard let base = puzzleBoxArray[index][outIndex] else {
                    continue
                }
                
                for j in (index + 1)...puzzleBoxArray.count {
                    
                    guard let approacher = puzzleBoxArray[j][outIndex] else {
                        continue
                    }
                    
                    if approacher.getScore() == base.getScore() {
                        
                        puzzleBoxArray[j][outIndex]?.move(to: base.getLocation())
                        
                        self.puzzleBoxArray[index][outIndex] = self.puzzleBoxArray[j][outIndex]
                        self.puzzleBoxArray[j][outIndex] = nil
                        self.puzzleBoxArray[index][outIndex]?.increase()
                            
                        
                        break outLoop
                    }
                }
            }
        }
    }
    
    func moveToUp() {
        for outIndex in 0..<puzzleBoxArray[0].count {
            
            for index in (0..<puzzleBoxArray.count) {
                
                if puzzleBoxArray[index][outIndex] != nil { continue }
                
                for j in index..<puzzleBoxArray.count {
                       
                    guard let approacher = puzzleBoxArray[j][outIndex] else {
                        continue
                    }
                    puzzleBoxArray[index][outIndex] = approacher
                    puzzleBoxArray[j][outIndex] = nil
                    
                    break
                }
            }
        }
    }
    
    func increaseCurrentScore(plus score: Int) {
        self.currentScore += score
    }
    
    func setTopScore(score: Int) {
        self.topScore = score
    }
    
    func makeNewPuzzleBox() {
        
        var emptySpace: [(Int, Int)] = []
        
        for a in 0..<puzzleBoxArray.count {
            for b in 0..<puzzleBoxArray[a].count {
                if puzzleBoxArray[a][b] == nil {
                    emptySpace.append((a, b))
                }
            }
        }
        
        let randomInt = Int.random(in: 0..<emptySpace.count)
        
        let result = emptySpace[randomInt]
        
        puzzleBoxArray[result.0][result.1] = PuzzleBoxModel(id: PuzzleBoxModel.newId, location: CGRect(x: 0, y: 0, width: 0, height: 0), color: ViewConst.boxColors[2]!, score: 2, textColor: ViewConst.textColors[2]!, position: (result.0, result.1))
        
        PuzzleBoxModel.newId += 1
    }
    
    func refreshPuzzleBoxArray() {
        
        for a in 0..<puzzleBoxArray.count {
            for b in 0..<puzzleBoxArray[a].count {        
                puzzleBoxArray[a][b]?.setPosition(position: (a, b))
            }
        }
    }
}


extension GameScreenModel {
    
    static var gameScreenRect: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
}
