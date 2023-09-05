//
//  PuzzleBox.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation
import SwiftUI

class PuzzleBoxModel: ObservableObject, PuzzleBoxModelStateProtocol {
    
    @Published private(set) var id: Int
    @Published private(set) var location: CGRect
    @Published private(set) var color: Color
    @Published private(set) var textColor: Color
    @Published private(set) var score: Int
    @Published private(set) var position: (Int, Int)
    
    init(id: Int, location: CGRect, color: Color, score: Int, textColor: Color, position: (Int, Int)) {
        self.id = id
        self.location = location
        self.color = color
        self.score = score
        self.textColor = textColor
        self.position = position
    }
    
    
}

extension PuzzleBoxModel: PuzzleBoxModelActionProtocol {
    
    func getID() -> Int {
        return id
    }
    
    func getLocation() -> CGRect {
        return location
    }
    
    func getColor() -> Color {
        return color
    }
    
    func getScore() -> Int {
        return score
    }
    
    func increase() {
        self.score *= 2
        self.color = ViewConst.boxColors[self.score]!
        self.textColor = ViewConst.textColors[self.score]!
    }
    
    func move(to location: CGRect) {
        
        self.location = location
    }
}


extension PuzzleBoxModel: Equatable {
    
    static func == (lhs: PuzzleBoxModel, rhs: PuzzleBoxModel) -> Bool {
        lhs.id == rhs.id
    }
}


extension PuzzleBoxModel {
    
    static var newId: Int = 0
    
}
