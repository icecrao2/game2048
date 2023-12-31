//
//  MainScreenIntentProtocol.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation


protocol MainScreenIntentProtocol{
    
    func viewOnAppear()
    
    func settingNavigationManager(_ settings: NavigationManager)
    
    func viewOnDisappear()
    
    func didTapLeftModeChangeButton()
    
    func didTapRigthModeChangeButton()
    
    func didTapGameStartButton()
    
    func didTapSettingButton() 
}
