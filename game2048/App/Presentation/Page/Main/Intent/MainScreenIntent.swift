//
//  MainViewIntent.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation


class MainScreenIntent {
    
    private weak var navigationManager: NavigationManager?
    
    private var model: MainScreenModelActionProtocol
    
    
    init(model: MainScreenModelActionProtocol) {
        self.model = model
    }
}


extension MainScreenIntent: MainScreenIntentProtocol {
    
    func viewOnAppear() {
        
    }
    
    func settingNavigationManager(_ settings: NavigationManager) {
        self.navigationManager = settings
    }
    
    func viewOnDisappear() {
        self.navigationManager = nil
    }
    
    func didTapLeftModeChangeButton() {
        model.changeModeTo(next: false)
    }
    
    func didTapRigthModeChangeButton() {
        model.changeModeTo(next: true)
    }
    
    func didTapClassicModeStartButton() {
        model.applyCurrentMode()
        navigationManager?.go(.ClassicModeView)
    }
    
    func didTapObstacleModeStartButton() {
        model.applyCurrentMode()
        navigationManager?.go(.ObstacleModeView)
    }
    
    func didTapSettingButton() {
        
    }
    
}
