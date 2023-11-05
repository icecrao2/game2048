//
//  GameScreenModel.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation


class GameScreenModel: ObservableObject, GameScreenModelStateProtocol {
    
    @Published var currentScore: Int = 0
    @Published var topScore: Int = 0
    
    @Published var puzzleBoxArray: [[PuzzleBoxModel?]]
    
    @Published var gameStatus: GamePhaseEnum = .playing
    
    var coppiedPuzzleBoxArray: [[PuzzleBoxModel?]]
    
    var coppiedCurrentScore: Int = 0
    var coppiedTopScore: Int = 0
    
    
    var puzzleBoxes: [PuzzleBoxModel] {
        
        var result: [PuzzleBoxModel] = []
        
        for i in 0..<puzzleBoxArray.count {
            for j in 0..<puzzleBoxArray[i].count {
                
                guard let box = puzzleBoxArray[i][j] else {
                    continue
                }
                result.append(box)
            }
        }
        
        return result
    }
    
    var scoreArray: [[Int]] {
        puzzleBoxArray.map { row in
            return row.map { box in
                box?.score ?? 0
            }
        }
    }
    
    init() {
        self.currentScore = 0
        self.topScore = 0
        
        self.puzzleBoxArray = [
            [nil, nil, nil, nil],
            [nil, nil, nil, nil],
            [nil, nil, nil, nil],
            [nil, nil, nil, nil]
        ]
        self.coppiedPuzzleBoxArray = [
            [nil, nil, nil, nil],
            [nil, nil, nil, nil],
            [nil, nil, nil, nil],
            [nil, nil, nil, nil]
        ]
    }
    
    init(currentScore: Int, topScore: Int, puzzleBoxArray: [[PuzzleBoxModel?]]) {
        self.currentScore = currentScore
        self.topScore = topScore
        
        self.puzzleBoxArray = puzzleBoxArray
        self.coppiedPuzzleBoxArray = puzzleBoxArray
    }
    
    
    func checkGameCompletion() -> Bool {
        
        if puzzleBoxes.count == 0 { return true }
        
        return !canSwipe(to: .left) && !canSwipe(to: .right) && !canSwipe(to: .up) && !canSwipe(to: .down)
    }
    
    
    
    func loadGame() {
        let mapSize = PuzzleBoxModel.map.0
        
        puzzleBoxArray = []
        
        for _ in 0..<mapSize {
            self.puzzleBoxArray.append([PuzzleBoxModel?](repeating: nil, count: mapSize))
        }
        
        let plist = UserDefaults.standard
        guard let data = plist.object(forKey: "game_save_\(mapSize)") as? Data else {
            
            reset()
            makeNewPuzzleBox()
            refreshPuzzleBoxArray()
            return
        }
        
        let decoder = JSONDecoder()
               
        guard let decodedGameSaver = try? decoder.decode(GameSaverUserDefaultDTO.self, from: data) else {
            
            reset()
            makeNewPuzzleBox()
            refreshPuzzleBoxArray()
            return
        }
        
        self.currentScore = decodedGameSaver.currentScore
        self.topScore = decodedGameSaver.topScore
        self.puzzleBoxArray = decodedGameSaver.puzzleBoxArray
        
        refreshPuzzleBoxArray()
    }
    
    
    func saveGame() {
        
        let encoder = JSONEncoder()
        
        let mapSize = PuzzleBoxModel.map.0
        
        let gameSaver = GameSaverUserDefaultDTO(topScore: topScore, currentScore: currentScore, puzzleBoxArray: puzzleBoxArray)
        
        if let encoded = try? encoder.encode(gameSaver) {
            let plist = UserDefaults.standard
            plist.setValue(encoded, forKey: "game_save_\(mapSize)")
            plist.synchronize()
            
        }
    }
    
}

extension GameScreenModel: GameScreenModelActionProtocol {
    
    
    func updateGameState() {
        
        if self.checkGameCompletion () {
            self.gameStatus = .gameOver
        } else {
            self.gameStatus = .playing
        }
    }
    
    func undoLastChange() {
        if currentScore == 0 { return }
        
        self.puzzleBoxArray = self.coppiedPuzzleBoxArray
        self.currentScore = self.coppiedCurrentScore
        self.topScore = self.coppiedTopScore
    }
    
    func reset() {
        
        puzzleBoxArray = []
        
        for i in 0..<PuzzleBoxModel.map.0 {
            puzzleBoxArray.append([])
            for _ in 0..<PuzzleBoxModel.map.1 {
                puzzleBoxArray[i].append(nil)
            }
        }
        
        
        for i in 0..<puzzleBoxArray.count {
            
            for j in 0..<puzzleBoxArray[i].count {
                puzzleBoxArray[i][j] = nil
            }
        }
        currentScore = 0
        coppiedCurrentScore = 0
        coppiedTopScore = 0
    }
    
    func canSwipe(to direction: Direction) -> Bool {
        
        let boxSwipeChecker: BoxSwipeAvailableCheckUseCase = BoxSwipeAvailableCheckUseCase()
        
        return boxSwipeChecker.canSwipe(to: direction, in: puzzleBoxArray)
        
    }
    
    
    func mergeToRight() {
        
        self.puzzleBoxArray = PuzzleBoxMergeUseCase.mergeToRight(puzzleBoxArray: puzzleBoxArray) { score in
            self.coppiedCurrentScore = self.currentScore
            self.coppiedTopScore = self.topScore
            
            self.increaseCurrentScore(plus: score)
            
            if self.currentScore >= self.topScore {
                self.setTopScore(score: self.currentScore)
            }
        }
    }
    
    
    func moveToRight() {
        
        self.puzzleBoxArray = PuzzleBoxMoveUseCase.moveToRight(puzzleBoxArray: puzzleBoxArray)
    }
    
    
    func mergeToLeft() {
        
        self.puzzleBoxArray = PuzzleBoxMergeUseCase.mergeToLeft(puzzleBoxArray: puzzleBoxArray) { score in
            self.coppiedCurrentScore = self.currentScore
            self.coppiedTopScore = self.topScore
            
            self.increaseCurrentScore(plus: score)
            
            if self.currentScore >= self.topScore {
                self.setTopScore(score: self.currentScore)
            }
        }
    }
    
    func moveToLeft() {
        
        self.puzzleBoxArray = PuzzleBoxMoveUseCase.moveToLeft(puzzleBoxArray: puzzleBoxArray)
    }
    
    func mergetToDown() {
        
        self.puzzleBoxArray = PuzzleBoxMergeUseCase.mergeToDown(puzzleBoxArray: puzzleBoxArray) { score in
            self.coppiedCurrentScore = self.currentScore
            self.coppiedTopScore = self.topScore
            
            self.increaseCurrentScore(plus: score)
            
            if self.currentScore >= self.topScore {
                self.setTopScore(score: self.currentScore)
            }
        }
    }
    
    
    func moveToDown() {
        
        self.puzzleBoxArray = PuzzleBoxMoveUseCase.moveToDown(puzzleBoxArray: puzzleBoxArray)
        
    }
    
    func mergetToUp() {
        
        self.puzzleBoxArray = PuzzleBoxMergeUseCase.mergeToUp(puzzleBoxArray: puzzleBoxArray) { score in
            self.coppiedCurrentScore = self.currentScore
            self.coppiedTopScore = self.topScore
            
            self.increaseCurrentScore(plus: score)
            
            if self.currentScore >= self.topScore {
                self.setTopScore(score: self.currentScore)
            }
        }
    }
    
    func moveToUp() {
        
        self.puzzleBoxArray = PuzzleBoxMoveUseCase.moveToUp(puzzleBoxArray: puzzleBoxArray)
        
    }
    
   
    func increaseCurrentScore(plus score: Int) {
        self.currentScore += score
    }
    
    func setTopScore(score: Int) {
        self.topScore = score
    }
    
    func makeNewPuzzleBox() {
        
        var emptySpace: [(Int, Int)] = []
        
        for a in 0..<puzzleBoxArray.count {
            for b in 0..<puzzleBoxArray[a].count {
                if puzzleBoxArray[a][b] == nil {
                    emptySpace.append((a, b))
                }
            }
        }
        
        let randomInt = Int.random(in: 0..<emptySpace.count)
        
        let result = emptySpace[randomInt]
        
        puzzleBoxArray[result.0][result.1] = PuzzleBoxModel(location: CGRect(x: 0, y: 0, width: 0, height: 0), score: 2, position: (result.0, result.1))
    }
    
    func makeNewObstacleBox() {
        
        var emptySpace: [(Int, Int)] = []
        
        for a in 0..<puzzleBoxArray.count {
            for b in 0..<puzzleBoxArray[a].count {
                if puzzleBoxArray[a][b] == nil {
                    emptySpace.append((a, b))
                }
            }
        }
        
        let randomInt = Int.random(in: 0..<emptySpace.count)
        
        let result = emptySpace[randomInt]
        
        puzzleBoxArray[result.0][result.1] = ObstacleBoxModel(location: CGRect(x: 0, y: 0, width: 0, height: 0), score: -2, position: (result.0, result.1))
    }
    
    
    func refreshPuzzleBoxArray() {
        
        for a in 0..<puzzleBoxArray.count {
            for b in 0..<puzzleBoxArray[a].count {        
                puzzleBoxArray[a][b]?.setPosition(position: (a, b))
            }
        }
    }
    
    func rememberCurrentPuzzleBoxArray() {
        coppiedPuzzleBoxArray = puzzleBoxArray
        
        for i in 0..<puzzleBoxArray.count {
            
            for j in 0..<puzzleBoxArray[i].count {
                
                guard let box = puzzleBoxArray[i][j] else {
                    coppiedPuzzleBoxArray[i][j] = nil
                    continue
                }
                coppiedPuzzleBoxArray[i][j] = PuzzleBoxModel(
                    location: box.location,
                    score: box.score,
                    position: box.position
                )
            }
        }
    }
}





extension GameScreenModel {
    
    static var gameScreenRect: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
}
