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
    
    func setPosition(position: (Int, Int)) {
        
        self.position = position
        
        let width = GameScreenModel.gameScreenRect.width / Double(PuzzleBoxModel.map.0)
        let height = GameScreenModel.gameScreenRect.height / Double(PuzzleBoxModel.map.1)
        
        let minX = 0 + (width * Double(position.0))
        let maxX = minX + width
        let x = (maxX + minX) / 2
        
        let minY = 0 + (height * Double(position.1))
        let maxY = minY + height
        let y = (maxY + minY) / 2
        
        self.location = CGRect(x: x, y: y, width: width, height: height)
    }
}


extension PuzzleBoxModel: Equatable {
    
    static func == (lhs: PuzzleBoxModel, rhs: PuzzleBoxModel) -> Bool {
        lhs.id == rhs.id
    }
}


extension PuzzleBoxModel {
    
    static var newId: Int = 0
    
    static var map: (Int, Int) = (4, 4)
}
