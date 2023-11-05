//
//  GameView.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency


extension GameScreen {

    
    static func obstacleModeBuild() -> some View {
        
        let model = ObstacleModeGameScreenModel()
        let intent = ObstacleModeGameScreenIntent(model: model)
        let container = MVIContainer(
            intent: intent as GameScreenIntentProtocol,
            model: model as GameScreenModelStateProtocol,
            modelChangePublisher: model.objectWillChange
        )
        
        let view = GameScreen(container: container)
        
        return view
    }
    
    
    static func build() -> some View {
        
        let model = GameScreenModel()
        let intent = GameScreenIntent(model: model)
        let container = MVIContainer(
            intent: intent as GameScreenIntentProtocol,
            model: model as GameScreenModelStateProtocol,
            modelChangePublisher: model.objectWillChange
        )
        
        let view = GameScreen(container: container)
        
        return view
        
    }
    
}

extension GameScreen {
    var body: some View {
        
        ZStack {
            
            build
                .onAppear {
                    intent.viewOnAppear()
                }
                .onDisappear {
                    intent.viewOnDisappear()
                }
            if model.gameStatus == .gameOver {
                gameOverPopup
            }
        }
    }
}




struct GameScreen: View {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
//    @EnvironmentObject var navigationManager: NavigationManager
    
    @StateObject var container: MVIContainer<GameScreenIntentProtocol, GameScreenModelStateProtocol>
    
    private var intent: GameScreenIntentProtocol { container.intent }
    private var model: GameScreenModelStateProtocol { container.model }
    
    var build: some View {
        
        GeometryReader { geo in
            
            VStack(spacing: 25) {
                
                HStack(spacing: geo.size.width * 0.03) {
                    
                    Text("\(PuzzleBoxModel.map.0)X\(PuzzleBoxModel.map.1)")
                        .frame(
                            width: geo.size.width * 0.28,
                            height: geo.size.height * 0.21
                        )
                        .font(Font.system(size: 100))
                        .minimumScaleFactor(0.1)
                        .fontWeight(.bold)
                        .padding(
                            .horizontal,
                            geo.size.width * 0.015
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 5)
                        )
                    
                    
                    VStack {
                        
                        HStack(spacing: geo.size.width * 0.03) {
                            
                            Text("\("점수".localize)\n\(model.currentScore)")
                                .foregroundColor(Color(hex: "F8F0E5"))
                                .multilineTextAlignment(.center)
                                .font(Font.system(size: 50))
                                .minimumScaleFactor(0.1)
                                .frame(
                                    width: geo.size.width * 0.24,
                                    height: geo.size.width * 0.15
                                )
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(ViewResources.palette3)
                                )
                            
                            Text("\("최고점수".localize)\n\(model.topScore)")
                                .foregroundColor(Color(hex: "F8F0E5"))
                                .multilineTextAlignment(.center)
                                .font(Font.system(size: 50))
                                .minimumScaleFactor(0.1)
                                .frame(
                                    width: geo.size.width * 0.24,
                                    height: geo.size.width * 0.15
                                )
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(ViewResources.palette3)
                                )
                        }
                        
                        Spacer()
                        
                        HStack {
                            
                            Button {
                                intent.didTapHomeButton()
                            } label: {
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .foregroundColor(Color(hex: "F8F0E5"))
                                    .multilineTextAlignment(.center)
                                    .padding(geo.size.width * 0.025)
                                    .frame(
                                        width: geo.size.width * 0.13,
                                        height: geo.size.width * 0.13
                                    )
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(ViewResources.highlightButtonColor)
                                    )
                            }
                            
                            Spacer()
                            
                            Button {
                                intent.didTapUndoButton()
                            } label: {
                                Image(systemName: "arrow.uturn.left")
                                    .resizable()
                                    .foregroundColor(Color(hex: "F8F0E5"))
                                    .multilineTextAlignment(.center)
                                    .padding(geo.size.width * 0.025)
                                    .frame(
                                        width: geo.size.width * 0.15,
                                        height: geo.size.width * 0.13
                                    )
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(ViewResources.highlightButtonColor)
                                    )
                            }
                            
                            Button {
                                intent.didTapResetButton()
                            } label: {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .resizable()
                                    .foregroundColor(Color(hex: "F8F0E5"))
                                    .multilineTextAlignment(.center)
                                    .padding(geo.size.width * 0.025)
                                    .frame(
                                        width: geo.size.width * 0.15,
                                        height: geo.size.width * 0.13
                                    )
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(ViewResources.highlightButtonColor)
                                    )
                            }
                        }
                    }
                    
                }
                .frame(
                    width: geo.size.width * 0.85,
                    height: geo.size.height * 0.2
                )
                .padding(.top, geo.size.height * 0.02)

                
                GeometryReader { geo in
                    ZStack {
                        ForEach(model.puzzleBoxes) { box in
                            
                            ZStack {
                                Text("\(box.score == -2 ? "X" : "\(box.score)")")
                                    .foregroundColor(ViewResources.textColors[box.score]!)
                                    .font(Font.system(size: 50))
                                    .minimumScaleFactor(0.1)
                                    .fontWeight(.bold)
                            }
                            .position(x: box.location.midX, y: box.location.midY)
                            .frame(width: box.location.width, height: box.location.height)
                            .animation(Animation.linear(duration: 0.1), value: box.location)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(ViewResources.boxColors[box.score]!)
                                    .id(box.id)
                                    .position(x: box.location.midX, y: box.location.midY)
                                    .frame(width: box.location.width, height: box.location.height)
                                    .animation(Animation.linear(duration: 0.1), value: box.location)
                            )
                        }
                    }
                    .onAppear {
                        GameScreenModel.gameScreenRect = geo.frame(in: .local)
                        intent.gameViewOnAppear()
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                intent.didDragChange(gesture.location)
                            }
                            .onEnded { gesture in
                                intent.didDragEnd()
                            }
                    )
                }
                .frame(
                    width: geo.size.width * 0.85,
                    height: geo.size.width * 0.85
                )
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(ViewResources.palette4, lineWidth: 10)
                        .background(.white)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    intent.didDragChange(gesture.location)
                                }
                                .onEnded { gesture in
                                    intent.didDragEnd()
                                }
                        )
                    
                )
                
                Spacer()
                
                GoogleAdView()
                    .frame(maxWidth: .infinity)
                    .frame(height: GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width).size.height)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ViewResources.palette1)
        }
    }
}


extension GameScreen {
    
    var gameOverPopup: some View {
        
        GeometryReader { geo in
            
            VStack {
                Text("Game Over")
                    .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.15)
                    .font(Font.system(size: 80))
                    .minimumScaleFactor(0.1)
                    .bold()
                    .foregroundColor(.white)
                
                VStack(spacing: geo.size.height * 0.03) {
                    
                    Button {
                        intent.didTapHomeButton()
                    } label: {
                        HStack {
                            Image(systemName: "house.fill")
                                .resizable()
                                .foregroundColor(Color(hex: "F8F0E5"))
                                .multilineTextAlignment(.center)
                                .padding(10)
                                .frame(
                                    width: verticalSizeClass == .compact ? geo.size.width * 0.08 : geo.size.width * 0.11,
                                    height: verticalSizeClass == .compact ? geo.size.width * 0.08 : geo.size.width * 0.11
                                )
                            
                            Text("돌아가기".localize)
                                .font(Font.system(size: 50))
                                .minimumScaleFactor(0.1)
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: geo.size.width * 0.4, height: geo.size.width * 0.08)
                            
                        }
                        .frame(width: geo.size.width * 0.6, height: geo.size.width * 0.1)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(ViewResources.highlightButtonColor)
                        )
                    }
                    
                    Button {
                        intent.didTapUndoButton()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.uturn.left")
                                .resizable()
                                .foregroundColor(Color(hex: "F8F0E5"))
                                .multilineTextAlignment(.center)
                                .padding(10)
                                .frame(
                                    width: verticalSizeClass == .compact ? geo.size.width * 0.08 : geo.size.width * 0.11,
                                    height: verticalSizeClass == .compact ? geo.size.width * 0.08 : geo.size.width * 0.11
                                )
                            
                            Text("되돌리기".localize)
                                .font(Font.system(size: 50))
                                .minimumScaleFactor(0.1)
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: geo.size.width * 0.4, height: geo.size.width * 0.08)
                        }
                        .frame(width: geo.size.width * 0.6, height: geo.size.width * 0.1)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(ViewResources.highlightButtonColor)
                        )
                    }
                    
                    Button {
                        intent.didTapResetButton()
                    } label: {
                        HStack{
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .resizable()
                                .foregroundColor(Color(hex: "F8F0E5"))
                                .multilineTextAlignment(.center)
                                .padding(10)
                                .frame(
                                    width: verticalSizeClass == .compact ? geo.size.width * 0.08 : geo.size.width * 0.11,
                                    height: verticalSizeClass == .compact ? geo.size.width * 0.08 : geo.size.width * 0.11
                                )
                            
                            
                            Text("다시하기".localize)
                                .font(Font.system(size: 50))
                                .minimumScaleFactor(0.1)
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: geo.size.width * 0.4, height: geo.size.width * 0.08)
                        }
                        .frame(width: geo.size.width * 0.6, height: geo.size.width * 0.1)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(ViewResources.highlightButtonColor)
                        )
                        
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Rectangle()
                    .fill(.gray.opacity(0.8))
                    .ignoresSafeArea()
            )
        }
    }
}

struct GameScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        GameScreen.build()
    }
}
