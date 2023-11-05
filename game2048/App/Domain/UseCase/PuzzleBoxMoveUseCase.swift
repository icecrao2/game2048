//
//  PuzzleBoxMoveUseCase.swift
//  game2048
//
//  Created by sw on 2023/11/05.
//

import Foundation


class PuzzleBoxMoveUseCase {
    
    
    static func moveToRight(puzzleBoxArray: [[PuzzleBoxModel?]]) -> [[PuzzleBoxModel?]] {
        
        var puzzleBoxArray = puzzleBoxArray
        
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
        
        return puzzleBoxArray
    }
    
    static func moveToLeft(puzzleBoxArray: [[PuzzleBoxModel?]]) -> [[PuzzleBoxModel?]]  {
        
        var puzzleBoxArray = puzzleBoxArray
        
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
        
        return puzzleBoxArray
    }
    
    
    
    static func moveToDown(puzzleBoxArray: [[PuzzleBoxModel?]]) -> [[PuzzleBoxModel?]]  {
        
        var puzzleBoxArray = puzzleBoxArray
        
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
        
        return puzzleBoxArray
    }
    
    static func moveToUp(puzzleBoxArray: [[PuzzleBoxModel?]]) -> [[PuzzleBoxModel?]]  {
        
        var puzzleBoxArray = puzzleBoxArray
        
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
        
        return puzzleBoxArray
    }
    
}
