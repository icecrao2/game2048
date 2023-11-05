//
//  GameScreenIntentProtocol.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation


protocol GameScreenIntentProtocol {
    
    func viewOnAppear()
    func gameViewOnAppear()
    
    func viewOnDisappear()
    
    func didDragChange(_ value: CGPoint)
    func didDragEnd()
    
    func didTapHomeButton()
    func didTapUndoButton()
    func didTapResetButton()
}

