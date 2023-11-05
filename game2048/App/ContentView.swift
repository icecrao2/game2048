//
//  ContentView.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var navigationManager: NavigationManager = NavigationManager.shared
    
    
    var body: some View {
        
        NavigationStack(path: $navigationManager.path) {
            
            build
                .navigationDestination(for: Int.self) { numb in
                    switch numb {
                    case NavigationManager.ViewCode.MainView.rawValue:
                        MainScreen.build()
                    case NavigationManager.ViewCode.ClassicModeView.rawValue:
                        GameScreen.build()
                    case NavigationManager.ViewCode.ObstacleModeView.rawValue:
                        GameScreen.obstacleModeBuild()
                    default:
                        EmptyView()
                    }
                }
                .onAppear {
                    
                }
            
        }
    }
    
}

extension ContentView {
    
    
    var build: some View {
        
        GeometryReader { proxy in
            
            ZStack {
                MainScreen.build()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ViewResources.palette1)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
