//
//  MainUI.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import SwiftUI

extension MainScreen {
    
    static func build() -> some View {
        
        let model = MainScreenModel()
        let intent = MainScreenIntent(model: model)
        let container = MVIContainer(
            intent: intent as MainScreenIntentProtocol,
            model: model as MainScreenModelStateProtocol,
            modelChangePublisher: model.objectWillChange
        )
        let view = MainScreen(container: container)
        
        return view
    }
    
}

extension MainScreen {
    var body: some View {
       
        build
            .onAppear { intent.viewOnAppear() }
            .onDisappear { intent.viewOnDisappear() }
        
    }
}

struct MainScreen: View {
    
    @StateObject private var container: MVIContainer<MainScreenIntentProtocol, MainScreenModelStateProtocol>
    
    private var intent: MainScreenIntentProtocol { container.intent }
    private var model: MainScreenModelStateProtocol { container.model }
    
    var build: some View {
        
        VStack(spacing: 37) {
            // 가상
            Image(systemName: "square")
                .resizable()
                .frame(width: 251, height: 251)
                .padding(.top, 50)
            
            
            HStack(spacing: 20) {
                
                Button {
                    intent.didTapLeftModeChangeButton()
                } label: {
                    Image(systemName: "arrowtriangle.left.square")
                        .resizable()
                        .frame(width: 37, height: 37)
                        .foregroundColor(ViewConst.highlightButtonColor)
                }
                
                Text(model.currentMode.rawValue)
                    .font(Font.system(size: 24))
                    .frame(width: 139)
                
                Button {
                    intent.didTapRigthModeChangeButton()
                } label: {
                    Image(systemName: "arrowtriangle.right.square")
                        .resizable()
                        .frame(width: 37, height: 37)
                        .foregroundColor(ViewConst.highlightButtonColor)
                }
            }
            
            VStack(spacing: 19) {
                
                Button {
                    //
                } label: {
                    Text("게임 시작")
                        .font(Font.system(size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(width: 251, height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(ViewConst.highlightButtonColor)
                        )
                }
                
                
                Button {
                    //
                } label: {
                    Text("게임 설정")
                        .font(Font.system(size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(width: 251, height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(ViewConst.palette4)
                        )
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(ViewConst.palette1)
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen.build()
    }
}
