//
//  PuzzleBox.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation
import SwiftUI


class PuzzleBoxModel: ObservableObject, PuzzleBoxModelStateProtocol, Identifiable, Codable {
    
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
    private enum CodingKeys: String, CodingKey {
        case id
        case location
        case color
        case textColor
        case score
        case position1
        case position2
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.location = try container.decode(CGRect.self, forKey: .location)
        
        let score = try container.decode(Int.self, forKey: .score)
 
        self.color = ViewConst.boxColors[score]!
        self.textColor = ViewConst.textColors[score]!
        self.score = score
        
        let position1 = try container.decode(Int.self, forKey: .position1)
        let position2 = try container.decode(Int.self, forKey: .position2)
        self.position = (position1, position2)
    }
     
     func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         
         try container.encode(id, forKey: .id)
         try container.encode(location, forKey: .location)
         try container.encode(score, forKey: .score)
         
         try container.encode(position.0, forKey: .position1)
         try container.encode(position.1, forKey: .position2)
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
        
        let width = GameScreenModel.gameScreenRect.width / Double(PuzzleBoxModel.map.1)
        let height = GameScreenModel.gameScreenRect.height / Double(PuzzleBoxModel.map.0)
        
        let minX = 0 + (width * Double(position.1))
        let minY = 0 + (height * Double(position.0))
        
        self.location = CGRect(x: minX, y: minY, width: width, height: height)
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
