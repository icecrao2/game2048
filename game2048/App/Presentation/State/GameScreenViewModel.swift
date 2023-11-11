//
//  GameScreenViewModel.swift
//  game2048
//
//  Created by sw on 2023/11/11.
//

import Foundation


class GameScreenViewModel: ObservableObject {
    
    @Published private var puzzleBoxMapModel: PuzzleBoxMapModel
    @Published private(set) var scoreModel: ScoreModel
    private var gameStatus: GamePhaseEnum = .playing
    
    var puzzleBoxMap: [[PuzzleBoxModel?]] {
        puzzleBoxMapModel.puzzleBoxArray
    }
    
    init(puzzleBoxMapModel: PuzzleBoxMapModel, scoreModel: ScoreModel) {
        self.puzzleBoxMapModel = puzzleBoxMapModel
        self.scoreModel = scoreModel
        
        self.puzzleBoxMapModel.addObserver(observer: self.scoreModel)
    }
    
    
    func canSwipe(to: Direction) -> Bool {
        puzzleBoxMapModel.canSwipe(to: to)
    }
    
    func checkGameCompletion() -> Bool {
        puzzleBoxMapModel.checkGameCompletion()
    }
    
    func readyToNextStage() {
        puzzleBoxMapModel.readyToNextStage()
        saveGame()
        updateGameState()
    }
    
    func reset() {
        puzzleBoxMapModel.reset()
        saveGame()
        updateGameState()
    }
    
    func undo() {
        puzzleBoxMapModel.undo()
        saveGame()
        updateGameState()
    }
    
    func swipe(to: Direction) {
        switch to {
        case .none:
            break
        case .up:
            puzzleBoxMapModel.swipteToUp()
        case .down:
            puzzleBoxMapModel.swipteTodown()
        case .left:
            puzzleBoxMapModel.swipteToLeft()
        case .right:
            puzzleBoxMapModel.swipeToRight()
        }
    }
    
    func loadGame() {
        let mapSize = PuzzleBoxModel.map.0
        
        var puzzleBoxArray: [[PuzzleBoxModel?]] = []
        
        for _ in 0..<mapSize {
            
            puzzleBoxArray.append([PuzzleBoxModel?](repeating: nil, count: mapSize))
            
            self.puzzleBoxMapModel = PuzzleBoxMapModel(puzzleBoxArray: puzzleBoxArray)
        }
        
        let plist = UserDefaults.standard
        guard let data = plist.object(forKey: "game_save_\(mapSize)") as? Data else {
            reset()
            return
        }
        
        let decoder = JSONDecoder()
               
        guard let decodedGameSaver = try? decoder.decode(GameSaverUserDefaultDTO.self, from: data) else {
            
            reset()
            return
        }
    
        self.scoreModel = ScoreModel(currentScore: decodedGameSaver.currentScore, topScore: decodedGameSaver.topScore)
        self.puzzleBoxMapModel = PuzzleBoxMapModel(puzzleBoxArray: decodedGameSaver.puzzleBoxArray)
        
        self.puzzleBoxMapModel.refresh()
    }
    
    private func updateGameState() {
        
        if self.checkGameCompletion () {
            self.gameStatus = .gameOver
        } else {
            self.gameStatus = .playing
        }
    }
    
    private func saveGame() {
        
        let encoder = JSONEncoder()
        
        let mapSize = PuzzleBoxModel.map.0
        
        let gameSaver = GameSaverUserDefaultDTO(
            topScore: scoreModel.topScore,
            currentScore: scoreModel.currentScore,
            puzzleBoxArray: puzzleBoxMapModel.puzzleBoxArray
        )
        
        if let encoded = try? encoder.encode(gameSaver) {
            let plist = UserDefaults.standard
            plist.setValue(encoded, forKey: "game_save_\(mapSize)")
            plist.synchronize()
            
        }
    }
}
