//
//  GameScreenIntentProtocol.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation
import SwiftUI

protocol GameScreenIntentProtocol {
    
    func viewOnAppear()
    func gameViewOnAppear()
    
    func settingNavigationManager(_ settings: NavigationManager?)
    func viewOnDisappear()
    
    func didDragChange(_ value: DragGesture.Value)
    func didDragEnd()
    
    func didTapHomeButton()
    func didTapUndoButton()
    func didTapResetButton()
}

