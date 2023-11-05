//
//  PuzzleBoxModelActionProtocol.swift
//  game2048
//
//  Created by sw on 2023/11/05.
//

import Foundation

protocol PuzzleBoxModelActionProtocol {
    
    func increase()
    func move(to location: CGRect)
    
    func getID() -> UUID
    func getLocation() -> CGRect
    func getScore() -> Int
    func setPosition(position: (Int, Int))
}

