//
//  MainViewIntent.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation


class MainScreenIntent {
    
    private var model: MainScreenModelActionProtocol
    
    
    init(model: MainScreenModelActionProtocol) {
        self.model = model
    }
}


extension MainScreenIntent: MainScreenIntentProtocol {
    
    func viewOnAppear() {
        
    }
    
    func viewOnDisappear() {
        
    }
    
    func didTapLeftModeChangeButton() {
        model.changeModeTo(next: false)
    }
    
    func didTapRigthModeChangeButton() {
        model.changeModeTo(next: true)
    }
    
    func didTapGameStartButton() {
        
    }
    
    func didTapSettingButton() {
        
    }
    
}
