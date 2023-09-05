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
        build
    }
}

struct GameScreen: View {
    
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
                    Text("점수\nxxxxx")
                        .foregroundColor(Color(hex: "F8F0E5"))
                        .multilineTextAlignment(.center)
                        .frame(width: 60, height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(ViewConst.palette3)
                        )
                    
                    Text("최고점수\nxxxxx")
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
                    let box1 = model.puzzleBoxArray[0][0]
                    let box2 = model.puzzleBoxArray[0][1]
                    
                    Rectangle()
                        .fill(box1!.color)
                        .frame(width: box1?.location.width, height: box1?.location.height)
                        .position(x: box1!.location.midX, y: box1!.location.midY)
                    
                    Rectangle()
                        .fill(box2!.color)
                        .frame(width: box2?.location.width, height: box2?.location.height)
                        .position(x: box2!.location.midX, y: box2!.location.midY)
                }
                .onAppear {
                    GameScreenModel.gameScreenRect = geo.frame(in: .local)
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(ViewConst.palette4, lineWidth: 10)
            )
            
            Spacer()
        }
        .padding(.horizontal, 21)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ViewConst.palette1)
    }
}

struct GameScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen.build()
    }
}
