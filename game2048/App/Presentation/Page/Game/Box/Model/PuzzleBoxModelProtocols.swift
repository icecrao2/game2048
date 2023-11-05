//
//  PuzzleBoxModelProtocols.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation

protocol PuzzleBoxModelStateProtocol {
 
    var id: UUID { get }
    var location: CGRect { get }
    var score: Int { get }
}

protocol PuzzleBoxModelActionProtocol {
    
    func increase()
    func move(to location: CGRect)
    
    func getID() -> UUID
    func getLocation() -> CGRect
    func getScore() -> Int
    func setPosition(position: (Int, Int))
}

