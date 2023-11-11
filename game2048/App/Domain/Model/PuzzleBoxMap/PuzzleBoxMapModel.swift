//
//  GameScreenModel.swift
//  game2048
//
//  Created by sw on 2023/09/03.
//

import Foundation


struct PuzzleBoxMapModel {

    fileprivate(set) var puzzleBoxArray: [[PuzzleBoxModel?]]
    private var coppiedPuzzleBoxArray: [[PuzzleBoxModel?]]
    private var observer: [PuzzleBoxGameScoreObserverProtocol] = []
    
    init(puzzleBoxArray: [[PuzzleBoxModel?]]) {
        self.puzzleBoxArray = puzzleBoxArray
        self.coppiedPuzzleBoxArray = puzzleBoxArray
    }

    mutating func addObserver(observer: PuzzleBoxGameScoreObserverProtocol) {
        self.observer.append(observer)
    }
    
    private mutating func sendPlusScoreMessage(score: Int) {
        for index in 0..<observer.count {
            observer[index].plus(score: score)
        }
    }

    private mutating func sendMinusScoreMessage(score: Int) {
        for index in 0..<observer.count {
            observer[index].minus(score: score)
        }
    }
    
    

    func checkGameCompletion() -> Bool {

        if checkPuzzleBoxIsEmpty() { return true }

        return !canSwipe(to: .left) && !canSwipe(to: .right) && !canSwipe(to: .up) && !canSwipe(to: .down)
    }

    private func checkPuzzleBoxIsEmpty() -> Bool {

        for i in 0..<puzzleBoxArray.count {
            for j in 0..<puzzleBoxArray[i].count {
                if puzzleBoxArray[i][j] != nil {
                    return false
                }
            }
        }
        return true
    }
    
    func canSwipe(to direction: Direction) -> Bool {

        let boxSwipeChecker: BoxSwipeAvailableCheckUseCase = BoxSwipeAvailableCheckUseCase()

        return boxSwipeChecker.canSwipe(to: direction, in: puzzleBoxArray)

    }
}


extension PuzzleBoxMapModel {

    mutating func undo() {
        undoLastChange()
        refreshPuzzleBoxArray()
    }
    
    private mutating func undoLastChange() {
        self.puzzleBoxArray = self.coppiedPuzzleBoxArray
    }

    
    mutating func reset() {
        resetStage()
        makeNewPuzzleBox()
        refreshPuzzleBoxArray()
    }
    
    private mutating func resetStage() {

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
    }
    
    
    mutating func makeNewGame() {
        
        makeNewPuzzleBox()
        refreshPuzzleBoxArray()
    }
    
    
    
    mutating func swipeToRight() {
        rememberCurrentPuzzleBoxArray()
        mergeToRight()
        moveToRight()
        refreshPuzzleBoxArray()
    }
    
    
    private mutating func mergeToRight() {

        for outIndex in 0..<puzzleBoxArray.count {
            
            outLoop: for index in (1..<puzzleBoxArray[outIndex].count).reversed() {
                
                guard let base = puzzleBoxArray[outIndex][index] else {
                    continue
                }
                
                for j in (0..<index).reversed() {
                    
                    guard let approacher = puzzleBoxArray[outIndex][j] else {
                        continue
                    }
                    
                    if approacher.getScore() == base.getScore() {
                        
                        puzzleBoxArray[outIndex][index] = puzzleBoxArray[outIndex][j]
                        puzzleBoxArray[outIndex][j] = nil
                        puzzleBoxArray[outIndex][index]?.increase()
                        
                        self.sendPlusScoreMessage(score: puzzleBoxArray[outIndex][index]!.getScore())
                        
                    }
                    continue outLoop
                }
            }
        }
    }


    private mutating func moveToRight() {

        self.puzzleBoxArray = PuzzleBoxMoveUseCase.moveToRight(puzzleBoxArray: puzzleBoxArray)
    }


    mutating func swipteToLeft() {
        rememberCurrentPuzzleBoxArray()
        mergeToLeft()
        moveToLeft()
        refreshPuzzleBoxArray()
    }
    
    private mutating func mergeToLeft() {
        
        for outIndex in 0..<puzzleBoxArray.count {
            
            outLoop: for index in 0..<(puzzleBoxArray[outIndex].count - 1) {
                
                guard let base = puzzleBoxArray[outIndex][index] else {
                    continue
                }
                
                for j in (index + 1)..<puzzleBoxArray[outIndex].count {
                    
                    guard let approacher = puzzleBoxArray[outIndex][j] else {
                        continue
                    }
                    
                    if approacher.getScore() == base.getScore() {
                        
                        puzzleBoxArray[outIndex][index] = puzzleBoxArray[outIndex][j]
                        puzzleBoxArray[outIndex][j] = nil
                        puzzleBoxArray[outIndex][index]?.increase()
                        
                        self.sendPlusScoreMessage(score:puzzleBoxArray[outIndex][index]!.getScore())
                    }
                    
                    continue outLoop
                }
            }
        }
    }

    private mutating func moveToLeft() {

        self.puzzleBoxArray = PuzzleBoxMoveUseCase.moveToLeft(puzzleBoxArray: puzzleBoxArray)
    }
    
    
    mutating func swipteTodown() {
        rememberCurrentPuzzleBoxArray()
        mergetToDown()
        moveToDown()
        refreshPuzzleBoxArray()
    }

    private mutating func mergetToDown() {

        for outIndex in 0..<puzzleBoxArray[0].count {
            
            outLoop: for index in (1..<puzzleBoxArray.count).reversed() {
                
                guard let base = puzzleBoxArray[index][outIndex] else {
                    continue
                }
                
                for j in (0..<index).reversed() {
                    
                    guard let approacher = puzzleBoxArray[j][outIndex] else {
                        continue
                    }
                    
                    if approacher.getScore() == base.getScore() {
                        
                        puzzleBoxArray[index][outIndex] = puzzleBoxArray[j][outIndex]
                        puzzleBoxArray[j][outIndex] = nil
                        puzzleBoxArray[index][outIndex]?.increase()
                        
                        sendPlusScoreMessage(score:puzzleBoxArray[index][outIndex]!.getScore())
                    }
                    
                    continue outLoop
                }
            }
        }
    }
    
    private mutating func moveToDown() {

        self.puzzleBoxArray = PuzzleBoxMoveUseCase.moveToDown(puzzleBoxArray: puzzleBoxArray)

    }

    
    mutating func swipteToUp() {
        rememberCurrentPuzzleBoxArray()
        mergetToUp()
        moveToUp()
        refreshPuzzleBoxArray()
    }
    
    private mutating func mergetToUp() {

        for outIndex in 0..<puzzleBoxArray[0].count {
            
            outLoop: for index in 0..<(puzzleBoxArray.count - 1) {
                
                guard let base = puzzleBoxArray[index][outIndex] else {
                    continue
                }
                
                for j in (index + 1)..<puzzleBoxArray.count {
                    
                    guard let approacher = puzzleBoxArray[j][outIndex] else {
                        continue
                    }
                    
                    if approacher.getScore() == base.getScore() {
                        
                        puzzleBoxArray[index][outIndex] = puzzleBoxArray[j][outIndex]
                        puzzleBoxArray[j][outIndex] = nil
                        puzzleBoxArray[index][outIndex]?.increase()
                        
                        self.sendPlusScoreMessage(score:puzzleBoxArray[index][outIndex]!.getScore())
                        
                    }
                    continue outLoop
                }
            }
        }
    }

    private mutating func moveToUp() {

        self.puzzleBoxArray = PuzzleBoxMoveUseCase.moveToUp(puzzleBoxArray: puzzleBoxArray)

    }

    private mutating func rememberCurrentPuzzleBoxArray() {
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
    
    
    mutating func readyToNextStage() {
        makeNewPuzzleBox()
        refreshPuzzleBoxArray()
    }
    
    
    private mutating func makeNewPuzzleBox() {

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

    

    private func refreshPuzzleBoxArray() {

        for a in 0..<puzzleBoxArray.count {
            for b in 0..<puzzleBoxArray[a].count {
                puzzleBoxArray[a][b]?.setPosition(position: (a, b))
            }
        }
    }

   
}





extension PuzzleBoxMapModel {

    static var gameScreenRect: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
}
