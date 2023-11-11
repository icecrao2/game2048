//
//  PuzzleBox.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation


class PuzzleBoxModel: Identifiable {
    
    private(set) var id = UUID()
    @Published private(set) var location: CGRect
    @Published private(set) var score: Int
    @Published private(set) var position: (Int, Int)
    
    init(id: UUID, location: CGRect, score: Int, position: (Int, Int)) {
        self.id = id
        self.location = location
        self.score = score
        self.position = position
    }
    
    init(location: CGRect, score: Int, position: (Int, Int)) {
        self.location = location
        self.score = score
        self.position = position
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.location = try container.decode(CGRect.self, forKey: .location)
        
        let score = try container.decode(Int.self, forKey: .score)
 
        self.score = score
        
        let position1 = try container.decode(Int.self, forKey: .position1)
        let position2 = try container.decode(Int.self, forKey: .position2)
        self.position = (position1, position2)
    }
    
    
    func getScore() -> Int {
        return score
    }
    
    func increase() {
        self.score *= 2
    }
}

extension PuzzleBoxModel {
    
    func getID() -> UUID {
        return id
    }
    
    func getLocation() -> CGRect {
        return location
    }
    
    func move(to location: CGRect) {
        
        self.location = location
    }
    
    func setPosition(position: (Int, Int)) {
        
        self.position = position
        
        updateLocation()
    }

    private func updateLocation() {
        
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
    
    static var map: (Int, Int) = (4, 4)
}



extension PuzzleBoxModel: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case location
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
