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
    @Published private(set) var score: Int
    
    init(id: Int, location: CGRect, color: Color, score: Int) {
        self.id = id
        self.location = location
        self.color = color
        self.score = score
    }
    
    
}

extension PuzzleBoxModel: PuzzleBoxModelActionProtocol {
    
    func increase() {
        self.score *= 2
        self.color = ViewConst.boxColors[self.score]!
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
