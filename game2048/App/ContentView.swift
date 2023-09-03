//
//  ContentView.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            
            MainScreen.build()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ViewConst.palette1)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
