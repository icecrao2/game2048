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
    
    @EnvironmentObject var navigationManager: NavigationManager
    
    @StateObject var container: MVIContainer<GameScreenIntentProtocol, GameScreenModelStateProtocol>
    
    private var intent: GameScreenIntentProtocol { container.intent }
    private var model: GameScreenModelStateProtocol { container.model }
    
    var build: some View {
        
        VStack(spacing: 25) {
            
            HStack {
                
                Text("2048")
                    .font(Font.system(size: 36))
                    .fontWeight(.bold)
                
                
                Spacer()
                
                HStack(spacing: 10) {
                    Text("점수\n\(model.currentScore)")
                        .foregroundColor(Color(hex: "F8F0E5"))
                        .multilineTextAlignment(.center)
                        .frame(width: 60, height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(ViewConst.palette3)
                        )
                    
                    Text("최고점수\n\(model.topScore)")
                        .foregroundColor(Color(hex: "F8F0E5"))
                        .multilineTextAlignment(.center)
                        .frame(width: 80, height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(ViewConst.palette3)
                        )
                }
            }
            .padding(.top, 41)
            
            HStack {
                
                Button {
                    intent.didTapHomeButton()
                } label: {
                    Image(systemName: "house.fill")
                        .resizable()
                        .foregroundColor(Color(hex: "F8F0E5"))
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .frame(width: 50, height: 50)
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
                            .padding(10)
                            .frame(width: 55, height: 50)
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
                            .padding(10)
                            .frame(width: 55, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(ViewConst.highlightButtonColor)
                            )
                    }
                }
            }
            
            GeometryReader { geo in
                ZStack {
                    ForEach(model.puzzleBoxes) { box in
                        
                        ZStack {
                            Text("\(box.score)")
                                .foregroundColor(box.textColor)
                                .font(Font.system(size: 26))
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
            .frame(width: 300, height: 300)
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


extension GameScreen {
    
    var gameOverPopup: some View {
        VStack {
            Text("Game Over")
                .font(Font.system(size: 36))
                .bold()
                .foregroundColor(.white)
            
            VStack(spacing: 15) {
                
                Button {
                    intent.didTapHomeButton()
                } label: {
                    HStack {
                        Image(systemName: "house.fill")
                            .resizable()
                            .foregroundColor(Color(hex: "F8F0E5"))
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .frame(width: 50, height: 50)
                        
                        Text("돌아가기")
                            .foregroundColor(.white)
                            .bold()
                        
                    }
                    .frame(width: 200, height: 60)
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
                            .frame(width: 55, height: 50)
                        
                        Text("되돌리기")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .frame(width: 200, height: 60)
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
                            .frame(width: 55, height: 50)
                        
                        
                        Text("다시하기")
                            .foregroundColor(.white)
                            .bold()
                    }
                    .frame(width: 200, height: 60)
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

struct GameScreen_Previews: PreviewProvider {
    
    static var navigationManager = NavigationManager()
    
    static var previews: some View {
        GameScreen.build()
            .environmentObject(navigationManager)
    }
}
