//
//  PuzzleBoxView.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import SwiftUI

struct PuzzleBoxView: View {
    
    @StateObject var model: PuzzleBoxModel
    
    var body: some View {
        
        VStack {
            Text(String(model.score))
                .font(Font.system(size: 100))
                .padding(10)
                .minimumScaleFactor(0.1)
                .foregroundColor(model.textColor)
        }
        .frame(width: model.location.width, height: model.location.height)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(model.color)
        )
    }
}

struct PuzzleBoxView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleBoxView(
            model: PuzzleBoxModel(
                location: CGRect(x: 0, y: 0, width: 50, height: 50),
                color: .red,
                score: 2,
                textColor: .white,
                position: (0,0)
            )
            
        )
    }
}
