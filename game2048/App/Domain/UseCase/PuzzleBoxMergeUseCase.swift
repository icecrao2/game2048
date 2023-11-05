//
//  PuzzleBoxMergeUseCase.swift
//  game2048
//
//  Created by sw on 2023/11/05.
//

import Foundation


class PuzzleBoxMergeUseCase {
    
    
    static func mergeToRight(puzzleBoxArray: [[PuzzleBoxModel?]], success: ( (_ score: Int) -> Void )? ) -> [[PuzzleBoxModel?]] {
        
        var puzzleBoxArray = puzzleBoxArray
        
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
                        
                        puzzleBoxArray[outIndex][index] = puzzleBoxArray[outIndex][j]
                        puzzleBoxArray[outIndex][j] = nil
                        puzzleBoxArray[outIndex][index]?.increase()
                        
                        success?(puzzleBoxArray[outIndex][index]!.getScore())
                        
                    }
                    continue outLoop
                }
            }
        }
        
        return puzzleBoxArray
    }
    
    static func mergeToLeft(puzzleBoxArray: [[PuzzleBoxModel?]], success: ( (_ score: Int) -> Void )? ) -> [[PuzzleBoxModel?]]  {
        
        var puzzleBoxArray = puzzleBoxArray
        
        
        for outIndex in 0..<puzzleBoxArray.count {
            
            outLoop: for index in 0..<(puzzleBoxArray[outIndex].count - 1) {
                
                guard let base = puzzleBoxArray[outIndex][index] else {
                    continue
                }
                
                for j in (index + 1)..<puzzleBoxArray[outIndex].count {
                    
                    guard let approacher = puzzleBoxArray[outIndex][j] else {
                        continue
                    }
                    
                    if approacher.getScore() == base.getScore() {
                        
                        puzzleBoxArray[outIndex][index] = puzzleBoxArray[outIndex][j]
                        puzzleBoxArray[outIndex][j] = nil
                        puzzleBoxArray[outIndex][index]?.increase()
                        
                        success?(puzzleBoxArray[outIndex][index]!.getScore())
                    }
                    
                    continue outLoop
                }
            }
        }
        
        return puzzleBoxArray
    }
    
    static func mergeToDown(puzzleBoxArray: [[PuzzleBoxModel?]], success: ( (_ score: Int) -> Void )? ) -> [[PuzzleBoxModel?]]  {
        
        var puzzleBoxArray = puzzleBoxArray
        
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
                        
                        puzzleBoxArray[index][outIndex] = puzzleBoxArray[j][outIndex]
                        puzzleBoxArray[j][outIndex] = nil
                        puzzleBoxArray[index][outIndex]?.increase()
                        
                        success?(puzzleBoxArray[index][outIndex]!.getScore())
                    }
                    
                    continue outLoop
                }
            }
        }
        
        return puzzleBoxArray
    }
    
    static func mergeToUp(puzzleBoxArray: [[PuzzleBoxModel?]], success: ( (_ score: Int) -> Void )? ) -> [[PuzzleBoxModel?]]  {
        
        var puzzleBoxArray = puzzleBoxArray
        
        for outIndex in 0..<puzzleBoxArray[0].count {
            
            outLoop: for index in 0..<(puzzleBoxArray.count - 1) {
                
                guard let base = puzzleBoxArray[index][outIndex] else {
                    continue
                }
                
                for j in (index + 1)..<puzzleBoxArray.count {
                    
                    guard let approacher = puzzleBoxArray[j][outIndex] else {
                        continue
                    }
                    
                    if approacher.getScore() == base.getScore() {
                        
                        puzzleBoxArray[index][outIndex] = puzzleBoxArray[j][outIndex]
                        puzzleBoxArray[j][outIndex] = nil
                        puzzleBoxArray[index][outIndex]?.increase()
                        
                        success?(puzzleBoxArray[index][outIndex]!.getScore())
                        
                    }
                    continue outLoop
                }
            }
        }
        
        return puzzleBoxArray
    }
}
