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
