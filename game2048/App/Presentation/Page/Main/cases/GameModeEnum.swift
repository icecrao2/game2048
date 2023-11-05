//
//  GameModeEnum.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation


enum GameModeEnum: String {
    
    case ThreeOnThree = "3X3"
    case FourOnFour = "4X4"
    case FiveOnFive = "5X5"
    case SixOnSix = "6X6"
    case EightOnEight = "8X8"
}


extension GameModeEnum: CaseIterable, Equatable {
    
    func next() -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
    
    func previous() -> Self {
       let all = Self.allCases
       let idx = all.firstIndex(of: self)!
       let previous = all.index(before: idx)
       return all[previous < all.startIndex ? all.index(before: all.endIndex) : previous]
   }
    
    func getMapSizeByTupleType() -> (Int, Int) {
        switch self {
        case .ThreeOnThree:
            return (3, 3)
        case .FourOnFour:
            return (4, 4)
        case .FiveOnFive:
            return (5, 5)
        case .SixOnSix:
            return (6, 6)
        case .EightOnEight:
            return (8, 8)
        }
    }
}
