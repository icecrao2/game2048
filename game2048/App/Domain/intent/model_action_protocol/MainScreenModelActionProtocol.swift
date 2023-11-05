//
//  MainScreenModelActionProtocol.swift
//  game2048
//
//  Created by sw on 2023/11/05.
//

import Foundation


protocol MainScreenModelActionProtocol {
    
    func changeModeTo(next: Bool)
    
    func applyCurrentMode()
}
