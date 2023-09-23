//
//  ContentView.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var navigationManager: NavigationManager = NavigationManager()
    
    
    var body: some View {
        
        NavigationStack(path: $navigationManager.path) {
            
            build
                .navigationDestination(for: Int.self) { numb in
                    switch numb {
                    case NavigationManager.ViewCode.MainView.rawValue:
                        MainScreen.build()
                    case NavigationManager.ViewCode.GameView.rawValue:
                        GameScreen.build()
                    default:
                        EmptyView()
                    }
                }
                .onAppear {
                    
                }
            
        }
        .environmentObject(navigationManager)
    }
    
}

extension ContentView {
    
    
    var build: some View {
        
        GeometryReader { proxy in
            
            ZStack {
                MainScreen.build()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ViewConst.palette1)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
