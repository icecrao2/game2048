//
//  PuzzleBoxMap.swift
//  game2048
//
//  Created by sw on 2023/11/05.
//

import Foundation


struct PuzzleBoxMap {
    
    private var puzzleBoxArray: [[PuzzleBoxModel?]]
    
    init(puzzleBoxArray: [[PuzzleBoxModel?]]) {
        self.puzzleBoxArray = puzzleBoxArray
    }
    
    subscript(row: Int, col: Int) -> PuzzleBoxModel? {
        get {
            return puzzleBoxArray[row][col]
        } set {
            puzzleBoxArray[row][col] = newValue
        }
    }
    
    func getPuzzleBoxArray() -> [[PuzzleBoxModel?]] {
        return puzzleBoxArray
    }
    
    func rowCount() -> Int {
        return puzzleBoxArray.count
    }
    
    func colCount(row: Int) -> Int {
        return puzzleBoxArray[row].count
    }
    
    mutating func clear() {
        puzzleBoxArray = []
    }
    
    mutating func append(_ element: [PuzzleBoxModel?]) {
        puzzleBoxArray.append(element)
    }
    
}
