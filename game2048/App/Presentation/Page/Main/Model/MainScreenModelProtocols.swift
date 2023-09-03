//
//  MainScreenModelProtocols.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation


protocol MainScreenModelStateProtocol {
 
    var currentMode: GameModeEnum { get }
}


protocol MainScreenModelActionProtocol {
    
    func changeModeTo(next: Bool)
}
