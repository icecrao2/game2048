//
//  MainUI.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        
        VStack(spacing: 37) {
            // 가상
            Image(systemName: "square")
                .resizable()
                .frame(width: 251, height: 251)
                .padding(.top, 50)
            
            
            HStack(spacing: 20) {
                
                Button {
                    //
                } label: {
                    Image(systemName: "arrowtriangle.left.square")
                        .resizable()
                        .frame(width: 37, height: 37)
                }
                
                Text("5X5")
                    .font(Font.system(size: 24))
                    .frame(width: 139)
                
                Button {
                    //
                } label: {
                    Image(systemName: "arrowtriangle.right.square")
                        .resizable()
                        .frame(width: 37, height: 37)
                }
            }
            
            VStack(spacing: 19) {
                
                Button {
                    //
                } label: {
                    Text("게임 시작")
                        .frame(width: 251, height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray)
                        )
                }
                
                
                Button {
                    //
                } label: {
                    Text("게임 설정")
                        .frame(width: 251, height: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.gray)
                        )
                }
            }
            
            
            
            Spacer()
        }
        
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
