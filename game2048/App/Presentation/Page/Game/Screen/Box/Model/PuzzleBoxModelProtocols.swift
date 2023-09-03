//
//  PuzzleBoxModelProtocols.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation
import SwiftUI

protocol PuzzleBoxModelStateProtocol {
 
    var id: Int { get }
    var location: CGRect { get }
    var color: Color { get }
    var score: Int { get }
}

protocol PuzzleBoxModelActionProtocol {
    
}
