//
//  PuzzleBoxModelProtocols.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation
import SwiftUI

protocol PuzzleBoxModelStateProtocol {
 
    var id: UUID { get }
    var location: CGRect { get }
    var color: Color { get }
    var score: Int { get }
}

protocol PuzzleBoxModelActionProtocol {
    
    func increase()
    func move(to location: CGRect)
    
    func getID() -> UUID
    func getLocation() -> CGRect
    func getColor() -> Color
    func getScore() -> Int
    func setPosition(position: (Int, Int))
}

