//
//  BoxSwipeAvailableChecker.swift
//  game2048
//
//  Created by sw on 2023/11/05.
//

import Foundation


class BoxSwipeAvailableCheckUseCase {
    
    func canSwipe(to direction: Direction, in puzzleBoxArray: [[PuzzleBoxModel?]]) -> Bool {
        
        switch direction {
        case .none:
            return false
        case .up:
            return canSwipeToUp(in: puzzleBoxArray)
        case .down:
            return canSwipeToDown(in: puzzleBoxArray)
        case .left:
            return canSwipeToLeft(in: puzzleBoxArray)
        case .right:
            return canSwipeToRight(in: puzzleBoxArray)
        }
    }
    
    private func canSwipeToRight(in puzzleBoxArray: [[PuzzleBoxModel?]]) -> Bool{
        
        for outIndex in 0..<puzzleBoxArray.count {
            
            outLoop: for index in (0..<puzzleBoxArray[outIndex].count).reversed() {
                
                if let base = puzzleBoxArray[outIndex][index] {
                    
                    for j in (0..<index).reversed() {
                        
                        guard let approacher = puzzleBoxArray[outIndex][j] else {
                            continue
                        }
                        
                        if approacher.getScore() == base.getScore() {
                            
                            return true
                        }
                        continue outLoop
                    }
                } else {
                    for j in (0..<index).reversed() {
                           
                        guard let _ = puzzleBoxArray[outIndex][j] else {
                            continue
                        }
                        
                        return true
                    }
                }
            }
        }
        return false
    }
    
    private func canSwipeToLeft(in puzzleBoxArray: [[PuzzleBoxModel?]]) -> Bool{
        
        for outIndex in 0..<puzzleBoxArray.count {
            
            outLoop: for index in 0..<(puzzleBoxArray[outIndex].count - 1) {
                
                if let base = puzzleBoxArray[outIndex][index] {
                    
                    
                    for j in (index + 1)..<puzzleBoxArray[outIndex].count {
                        
                        guard let approacher = puzzleBoxArray[outIndex][j] else {
                            continue
                        }
                        
                        if approacher.getScore() == base.getScore() {
                            return true
                        }
                        continue outLoop
                    }
                } else {
                    for j in index..<puzzleBoxArray[outIndex].count {
                           
                        guard let _ = puzzleBoxArray[outIndex][j] else {
                            continue
                        }
                        return true
                    }
                }
            }
        }
        return false
    }

    
    private func canSwipeToDown(in puzzleBoxArray: [[PuzzleBoxModel?]]) -> Bool{
        
        for outIndex in 0..<puzzleBoxArray[0].count {
            
            outLoop: for index in (1..<puzzleBoxArray.count).reversed() {
                
                if let base = puzzleBoxArray[index][outIndex]{
                    
                    for j in (0..<index).reversed() {
                        
                        guard let approacher = puzzleBoxArray[j][outIndex] else {
                            continue
                        }
                        
                        if approacher.getScore() == base.getScore() {
                            return true
                        }
                        
                        continue outLoop
                    }
                } else {
                    for j in (0..<index).reversed() {
                           
                        guard let _ = puzzleBoxArray[j][outIndex] else {
                            continue
                        }
                        return true
                    }
                }
            }
        }
        return false
    }
    
    private func canSwipeToUp(in puzzleBoxArray: [[PuzzleBoxModel?]]) -> Bool{
        
        for outIndex in 0..<puzzleBoxArray[0].count {
            
            outLoop: for index in 0..<(puzzleBoxArray.count - 1) {
                
                if let base = puzzleBoxArray[index][outIndex] {
                    
                    for j in (index + 1)..<puzzleBoxArray.count {
                        
                        guard let approacher = puzzleBoxArray[j][outIndex] else {
                            continue
                        }
                        
                        if approacher.getScore() == base.getScore() {
                            
                            return true
                        }
                        continue outLoop
                    }
                } else {
                    for j in index..<puzzleBoxArray.count {
                           
                        guard let _ = puzzleBoxArray[j][outIndex] else {
                            continue
                        }
                        return true
                    }
                }
            }
        }
        return false
    }
}
