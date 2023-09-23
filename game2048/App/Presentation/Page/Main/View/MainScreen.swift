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

struct MainScreen {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    @StateObject private var container: MVIContainer<MainScreenIntentProtocol, MainScreenModelStateProtocol>
    
    private var intent: MainScreenIntentProtocol { container.intent }
    private var model: MainScreenModelStateProtocol { container.model }
    
    var body: some View {
       
        build
            .onAppear {
                intent.settingNavigationManager(navigationManager)
                intent.viewOnAppear()
            }
            .onDisappear { intent.viewOnDisappear() }
        
    }
}

extension MainScreen: View {
    
    
    var build: some View {
        
        GeometryReader { geo in
            
            VStack(spacing: geo.size.height * 0.06) {
                // 가상
                Image(systemName: "square")
                    .resizable()
                    .frame(
                        width: verticalSizeClass == .compact ? geo.size.width * 0.45 : geo.size.height * 0.45, height: verticalSizeClass == .compact ? geo.size.width * 0.45 : geo.size.height * 0.45)
                    .padding(.top, 50)
                
                
                HStack(spacing: 20) {
                    
                    Button {
                        intent.didTapLeftModeChangeButton()
                    } label: {
                        Image(systemName: "arrowtriangle.left.square")
                            .resizable()
                            .frame(
                                width: verticalSizeClass == .compact ? geo.size.width * 0.04 : geo.size.height * 0.05,
                                height: verticalSizeClass == .compact ? geo.size.width * 0.04 : geo.size.height * 0.05
                            )
                            .foregroundColor(ViewConst.highlightButtonColor)
                    }
                    
                    Text(model.currentMode.rawValue)
                        .font(Font.system(size: 50))
                        .minimumScaleFactor(0.1)
                        .frame(
                            width: geo.size.width * 0.2,
                            height: 50
                        )
                    
                    Button {
                        intent.didTapRigthModeChangeButton()
                    } label: {
                        Image(systemName: "arrowtriangle.right.square")
                            .resizable()
                            .frame(
                                width: verticalSizeClass == .compact ? geo.size.width * 0.04 : geo.size.height * 0.05,
                                height: verticalSizeClass == .compact ? geo.size.width * 0.04 : geo.size.height * 0.05
                            )
                            .foregroundColor(ViewConst.highlightButtonColor)
                    }
                }
                
                VStack(spacing: geo.size.height * 0.03) {
                    
                    Button {
                        intent.didTapGameStartButton()
                    } label: {
                        Text("게임 시작")
                            .font(Font.system(size: 30))
                            .minimumScaleFactor(0.1)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(
                                width: verticalSizeClass == .compact ? geo.size.width * 0.45 : geo.size.height * 0.45, height: verticalSizeClass == .compact ? geo.size.width * 0.06 : geo.size.height * 0.06)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(ViewConst.highlightButtonColor)
                            )
                    }
                    
                    
                    Button {
                        //
                    } label: {
                        Text("게임 설정")
                            .font(Font.system(size: 30))
                            .minimumScaleFactor(0.1)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(
                                width: verticalSizeClass == .compact ? geo.size.width * 0.45 : geo.size.height * 0.45, height: verticalSizeClass == .compact ? geo.size.width * 0.06 : geo.size.height * 0.06)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(ViewConst.palette4)
                            )
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    
    private static var navigationManager = NavigationManager()
    
    static var previews: some View {
        MainScreen.build()
            .environmentObject(navigationManager)
    }
}
