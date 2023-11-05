//
//  ObstacleModeGameScreenModel.swift
//  game2048
//
//  Created by sw on 2023/10/16.
//

import Foundation


class ObstacleModeGameScreenModel: GameScreenModel {
    
    override func loadGame() {
        let mapSize = PuzzleBoxModel.map.0
        
        puzzleBoxArray = []
        
        for _ in 0..<mapSize {
            self.puzzleBoxArray.append([PuzzleBoxModel?](repeating: nil, count: mapSize))
        }
        
        let plist = UserDefaults.standard
        guard let data = plist.object(forKey: "game_save_obstacle_\(mapSize)") as? Data else {
            
            reset()
            makeNewPuzzleBox()
            makeNewObstacleBox()
            refreshPuzzleBoxArray()
            return
        }
        
        let decoder = JSONDecoder()
               
        guard let decodedGameSaver = try? decoder.decode(GameSaverUserDefaultDTO.self, from: data) else {
            
            reset()
            makeNewPuzzleBox()
            makeNewObstacleBox()
            refreshPuzzleBoxArray()
            return
        }
        
        self.currentScore = decodedGameSaver.currentScore
        self.topScore = decodedGameSaver.topScore
        self.puzzleBoxArray = decodedGameSaver.puzzleBoxArray
        
        refreshPuzzleBoxArray()
    }
    
    
    override func saveGame() {
        
        let encoder = JSONEncoder()
        
        let mapSize = PuzzleBoxModel.map.0
        
        let gameSaver = GameSaverUserDefaultDTO(topScore: topScore, currentScore: currentScore, puzzleBoxArray: puzzleBoxArray)
        
        if let encoded = try? encoder.encode(gameSaver) {
            let plist = UserDefaults.standard
            plist.setValue(encoded, forKey: "game_save_obstacle_\(mapSize)")
            plist.synchronize()
            
        }
    }
}
