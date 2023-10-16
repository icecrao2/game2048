//
//  ObstacleBoxModel.swift
//  game2048
//
//  Created by sw on 2023/10/15.
//

import Foundation
import SwiftUI


class ObstacleBoxModel: ObservableObject, PuzzleBoxModelStateProtocol, Identifiable {
    
    private(set) var id = UUID()
    @Published private(set) var location: CGRect
    @Published private(set) var color: Color
    @Published private(set) var textColor: Color
    @Published private(set) var score: Int
    @Published private(set) var position: (Int, Int)
    
    init(id: UUID, location: CGRect, color: Color, score: Int, textColor: Color, position: (Int, Int)) {
        self.id = id
        self.location = location
        self.color = color
        self.score = score
        self.textColor = textColor
        self.position = position
    }
    
    init(location: CGRect, color: Color, score: Int, textColor: Color, position: (Int, Int)) {
        self.location = location
        self.color = color
        self.score = score
        self.textColor = textColor
        self.position = position
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.location = try container.decode(CGRect.self, forKey: .location)
        
        let score = try container.decode(Int.self, forKey: .score)
 
        self.color = ViewConst.boxColors[score]!
        self.textColor = ViewConst.textColors[score]!
        self.score = score
        
        let position1 = try container.decode(Int.self, forKey: .position1)
        let position2 = try container.decode(Int.self, forKey: .position2)
        self.position = (position1, position2)
    }
}

extension ObstacleBoxModel: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case location
        case color
        case textColor
        case score
        case position1
        case position2
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
