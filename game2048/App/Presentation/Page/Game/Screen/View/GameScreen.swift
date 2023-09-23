//
//  GameView.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import SwiftUI


extension GameScreen {

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
                    intent.settingNavigationManager(navigationManager)
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
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    @StateObject var container: MVIContainer<GameScreenIntentProtocol, GameScreenModelStateProtocol>
    
    private var intent: GameScreenIntentProtocol { container.intent }
    private var model: GameScreenModelStateProtocol { container.model }
    
    var build: some View {
        
        GeometryReader { geo in
            
            VStack(spacing: 25) {
                
                HStack {
                    
                    Text("2048")
                        .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.1)
                        .font(Font.system(size: 100))
                        .minimumScaleFactor(0.1)
                        .fontWeight(.bold)
                    
                    
                    Spacer()
                    
                    HStack(spacing: geo.size.width * 0.03) {
                        Text("점수\n\(model.currentScore)")
                            .foregroundColor(Color(hex: "F8F0E5"))
                            .multilineTextAlignment(.center)
                            .font(Font.system(size: 50))
                            .minimumScaleFactor(0.1)
                            .frame(
                                width: geo.size.width * 0.12,
                                height: geo.size.width * 0.12
                            )
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(ViewConst.palette3)
                            )
                        
                        Text("최고점수\n\(model.topScore)")
                            .foregroundColor(Color(hex: "F8F0E5"))
                            .multilineTextAlignment(.center)
                            .font(Font.system(size: 50))
                            .minimumScaleFactor(0.1)
                            .frame(
                                width: geo.size.width * 0.15,
                                height: geo.size.width * 0.12
                            )
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(ViewConst.palette3)
                            )
                    }
                }
                .frame(width: geo.size.width * 0.85)
                .padding(.top, geo.size.height * 0.02)
                
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
                                    .fill(ViewConst.highlightButtonColor)
                            )
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            intent.didTapUndoButton()
                        } label: {
                            Image(systemName: "arrow.uturn.left")
                                .resizable()
                                .foregroundColor(Color(hex: "F8F0E5"))
                                .multilineTextAlignment(.center)
                                .padding(geo.size.width * 0.025)
                                .frame(
                                    width: geo.size.width * 0.14,
                                    height: geo.size.width * 0.13
                                )
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(ViewConst.highlightButtonColor)
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
                                        .fill(ViewConst.highlightButtonColor)
                                )
                        }
                    }
                }
                .frame(width: geo.size.width * 0.85)
                
                GeometryReader { geo in
                    ZStack {
                        ForEach(model.puzzleBoxes) { box in
                            
                            ZStack {
                                Text("\(box.score)")
                                    .foregroundColor(box.textColor)
                                    .font(Font.system(size: 50))
                                    .minimumScaleFactor(0.1)
                                    .fontWeight(.bold)
                            }
                            .position(x: box.location.midX, y: box.location.midY)
                            .frame(width: box.location.width, height: box.location.height)
                            .animation(.default, value: box.location)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(box.color)
                                    .id(box.id)
                                    .position(x: box.location.midX, y: box.location.midY)
                                    .frame(width: box.location.width, height: box.location.height)
                                    .animation(.default, value: box.location)
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
                                intent.didDragChange(gesture)
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
                        .stroke(ViewConst.palette4, lineWidth: 10)
                        .background(.white)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    intent.didDragChange(gesture)
                                }
                                .onEnded { gesture in
                                    intent.didDragEnd()
                                }
                        )
                    
                )
                
                Spacer()
            }
            .padding(.horizontal, 21)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ViewConst.palette1)
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
                            
                            Text("돌아가기")
                                .font(Font.system(size: 50))
                                .minimumScaleFactor(0.1)
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: geo.size.width * 0.4, height: geo.size.width * 0.08)
                            
                        }
                        .frame(width: geo.size.width * 0.6, height: geo.size.width * 0.1)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(ViewConst.highlightButtonColor)
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
                            
                            Text("되돌리기")
                                .font(Font.system(size: 50))
                                .minimumScaleFactor(0.1)
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: geo.size.width * 0.4, height: geo.size.width * 0.08)
                        }
                        .frame(width: geo.size.width * 0.6, height: geo.size.width * 0.1)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(ViewConst.highlightButtonColor)
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
                            
                            
                            Text("다시하기")
                                .font(Font.system(size: 50))
                                .minimumScaleFactor(0.1)
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: geo.size.width * 0.4, height: geo.size.width * 0.08)
                        }
                        .frame(width: geo.size.width * 0.6, height: geo.size.width * 0.1)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(ViewConst.highlightButtonColor)
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
    
    static var navigationManager = NavigationManager()
    
    static var previews: some View {
        GameScreen.build()
            .environmentObject(navigationManager)
    }
}
