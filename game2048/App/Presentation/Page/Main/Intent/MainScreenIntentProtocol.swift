//
//  MainScreenIntentProtocol.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation


protocol MainScreenIntentProtocol{
    
    func viewOnAppear()
    
    func viewOnDisappear()
    
    func didTapLeftModeChangeButton()
    
    func didTapRigthModeChangeButton()
    
    func didTapClassicModeStartButton()
    
    func didTapObstacleModeStartButton()
    
    func didTapSettingButton() 
}
