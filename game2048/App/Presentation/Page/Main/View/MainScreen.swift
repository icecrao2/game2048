//
//  MainUI.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency

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
                
                Text("2048")
                    .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.1)
                    .font(Font.system(size: 100))
                    .minimumScaleFactor(0.1)
                    .fontWeight(.bold)
                    .padding(0)
                    .padding(.top, geo.size.height * 0.05)
                    .padding(.bottom, geo.size.height * 0.05)
                
                ZStack {
                    
                    HStack(spacing: verticalSizeClass == .compact ? geo.size.width * 0.02 : geo.size.height * 0.025) {
                        
                        Button {
                            intent.didTapLeftModeChangeButton()
                        } label: {
                            
                            ZStack {
                                
                                Image(systemName: "arrowtriangle.left.square")
                                    .resizable()
                                    .frame(
                                        width: geo.size.width * 0.16,
                                        height: geo.size.width * 0.16
                                    )
                                    .foregroundColor(ViewConst.highlightButtonColor)
                            }
                            .frame(
                                width: geo.size.width * 0.16,
                                height: geo.size.width * 0.55
                            )
                                
                        }
                        
                        Image(model.currentMode.rawValue)
                            .resizable()
                            .frame(
                                width: geo.size.width * 0.55,
                                height: geo.size.width * 0.55
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 5)
                                    .foregroundColor(.gray)
                                
                            )
                        
                        Button {
                            intent.didTapRigthModeChangeButton()
                        } label: {
                            
                            ZStack {
                                Image(systemName: "arrowtriangle.right.square")
                                    .resizable()
                                    .frame(
                                        width: geo.size.width * 0.16,
                                        height: geo.size.width * 0.16
                                    )
                                    .foregroundColor(ViewConst.highlightButtonColor)
                            }
                            .frame(
                                width: geo.size.width * 0.16,
                                height: geo.size.width * 0.55
                            )
                        }
                        
                    }
                    .padding(.bottom, 0)
                    
                    Text(model.currentMode.rawValue)
                        .font(Font.system(size: 100))
                        .minimumScaleFactor(0.1)
                        .frame(
                            width: geo.size.width * 0.4,
                            height: geo.size.height * 0.15
                        )
                    
                }
                .padding(.bottom, geo.size.height * 0.04)
                
                
                VStack(spacing: geo.size.height * 0.03) {
                    
                    Button {
                        intent.didTapGameStartButton()
                    } label: {
                        Text("게임 시작".localize)
                            .font(Font.system(size: 30))
                            .minimumScaleFactor(0.1)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .frame(
                                width: verticalSizeClass == .compact ? geo.size.width * 0.45 : geo.size.height * 0.45, height: verticalSizeClass == .compact ? geo.size.width * 0.08 : geo.size.height * 0.08)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(ViewConst.highlightButtonColor)
                            )
                    }
                }
                
                Spacer()
                
                GoogleAdView()
                    .frame(maxWidth: .infinity)
                    .frame(height: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width).size.height)
                
                
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
