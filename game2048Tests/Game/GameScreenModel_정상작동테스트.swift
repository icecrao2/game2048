//
//  GameScreenModel_정상작동테스트.swift
//  game2048Tests
//
//  Created by sw on 2023/09/03.
//

import XCTest
@testable import game2048
import SwiftUI


final class GameScreenModel_정상작동테스트: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_mergeToRight_정상작동테스트() throws {
        
        let sut = GameScreenModel(currentScore: 0, topScore: 0, puzzleBoxArray: [
            [nil, nil, nil],
            [PuzzleBoxModel(id: 1, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), PuzzleBoxModel(id: 0, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,2)), nil],
            [nil, nil, nil],
        ])
        
        sut.mergeToRight()
     
        let expectedResult = [
    [nil, nil, nil],
    [nil, PuzzleBoxModel(id: 0, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 4, textColor: .red, position: (1,2)), nil],
    [nil, nil, nil],
        ]
        
        
        XCTAssertEqual(expectedResult[1][1]?.getScore(), sut.puzzleBoxArray[1][1]?.getScore())
    }
    
    func test_moveToRight_정상작동테스트() throws {
        
        let sut = GameScreenModel(currentScore: 0, topScore: 0, puzzleBoxArray: [
            [PuzzleBoxModel(id: 3, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), nil, nil],
            [PuzzleBoxModel(id: 1, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), PuzzleBoxModel(id: 0, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,2)), nil],
            [PuzzleBoxModel(id: 4, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), nil, PuzzleBoxModel(id: 5, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1))],
        ])
        
        sut.moveToRight()
        
        let expectedResult = [
            [nil, nil, PuzzleBoxModel(id: 3, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1))],
            [nil, PuzzleBoxModel(id: 1, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), PuzzleBoxModel(id: 0, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,2))],
            [nil, PuzzleBoxModel(id: 4, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), PuzzleBoxModel(id: 5, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1))],
        ]
        
        XCTAssertEqual(expectedResult, sut.puzzleBoxArray)
        
    }
    
    func test_mergeToLeft_정상작동테스트() throws {
        
        let sut = GameScreenModel(currentScore: 0, topScore: 0, puzzleBoxArray: [
            [nil, nil, nil],
            [PuzzleBoxModel(id: 1, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), PuzzleBoxModel(id: 0, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,2)), nil],
            [PuzzleBoxModel(id: 3, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), nil, PuzzleBoxModel(id: 4, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1))],
        ])
        
        sut.mergeToLeft()
     
        let expectedResult = [
    [nil, nil, nil],
    [PuzzleBoxModel(id: 0, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 4, textColor: .red, position: (1,2)), nil, nil],
    [PuzzleBoxModel(id: 4, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 4, textColor: .red, position: (1,1)), nil, nil],
        ]
        
        
        XCTAssertEqual(expectedResult[1][0]?.getScore(), sut.puzzleBoxArray[1][0]?.getScore())
        XCTAssertEqual(expectedResult[1][1]?.getScore(), sut.puzzleBoxArray[1][1]?.getScore())
        XCTAssertEqual(expectedResult[1][2]?.getScore(), sut.puzzleBoxArray[1][2]?.getScore())
        XCTAssertEqual(expectedResult[2][0]?.getScore(), sut.puzzleBoxArray[2][0]?.getScore())
        XCTAssertEqual(expectedResult[2][1]?.getScore(), sut.puzzleBoxArray[2][1]?.getScore())
        XCTAssertEqual(expectedResult[2][2]?.getScore(), sut.puzzleBoxArray[2][2]?.getScore())
    }
    
    func test_moveToLeft_정상작동테스트() throws {
        
        let sut = GameScreenModel(currentScore: 0, topScore: 0, puzzleBoxArray: [
            [nil, nil, PuzzleBoxModel(id: 3, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1))],
            [nil, PuzzleBoxModel(id: 1, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), PuzzleBoxModel(id: 0, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,2))],
            [PuzzleBoxModel(id: 4, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), nil, PuzzleBoxModel(id: 5, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1))],
        ])
        
        sut.moveToLeft()
        
        let expectedResult = [
            [PuzzleBoxModel(id: 3, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), nil, nil],
            [PuzzleBoxModel(id: 1, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), PuzzleBoxModel(id: 0, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,2)), nil],
            [PuzzleBoxModel(id: 4, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), PuzzleBoxModel(id: 5, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), nil],
        ]
        
        XCTAssertEqual(expectedResult, sut.puzzleBoxArray)
        
    }
    
    func test_mergeToDown_정상작동테스트() throws {
        
        let sut = GameScreenModel(currentScore: 0, topScore: 0, puzzleBoxArray: [
            [nil, PuzzleBoxModel(id: 0, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,2)), nil],
            [nil, nil, PuzzleBoxModel(id: 4, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1))],
            [nil, PuzzleBoxModel(id: 1, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), PuzzleBoxModel(id: 3, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1))],
        ])
        
        sut.mergetToDown()
     
        let expectedResult = [
    [nil, nil, nil],
    [nil , nil, nil],
    [nil, PuzzleBoxModel(id: 0, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 4, textColor: .red, position: (1,2)), PuzzleBoxModel(id: 4, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 4, textColor: .red, position: (1,1))]
        ]
        
        XCTAssertEqual(expectedResult[2][1]?.getScore(), sut.puzzleBoxArray[2][1]?.getScore())
        XCTAssertEqual(expectedResult[2][2]?.getScore(), sut.puzzleBoxArray[2][2]?.getScore())
    }
    
    
    func test_moveToDown_정상작동테스트() throws {
        
        let sut = GameScreenModel(currentScore: 0, topScore: 0, puzzleBoxArray: [
            [PuzzleBoxModel(id: 3, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), nil, nil],
            [PuzzleBoxModel(id: 1, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), PuzzleBoxModel(id: 0, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,2)), nil],
            [PuzzleBoxModel(id: 4, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), nil, PuzzleBoxModel(id: 5, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1))],
        ])
        
        sut.moveToDown()
        
        let expectedResult = [
            [PuzzleBoxModel(id: 3, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), nil, nil],
            [PuzzleBoxModel(id: 1, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), nil, nil],
            [PuzzleBoxModel(id: 4, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), PuzzleBoxModel(id: 0, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,2)), PuzzleBoxModel(id: 5, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1))],
        ]
        
        XCTAssertEqual(expectedResult, sut.puzzleBoxArray)
        
    }
    
    func test_mergeToUp_정상작동테스트() throws {
        
        let sut = GameScreenModel(currentScore: 0, topScore: 0, puzzleBoxArray: [
            [nil, PuzzleBoxModel(id: 0, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,2)), PuzzleBoxModel(id: 4, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1))],
            [nil, nil, nil],
            [nil, PuzzleBoxModel(id: 1, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), PuzzleBoxModel(id: 3, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1))],
        ])
        
        sut.mergetToUp()
     
        let expectedResult = [
    [nil, PuzzleBoxModel(id: 1, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 4, textColor: .red, position: (1,2)), PuzzleBoxModel(id: 3, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 4, textColor: .red, position: (1,1))],
    [nil , nil, nil],
    [nil, nil, nil]
        ]
        
        XCTAssertEqual(expectedResult[2][1]?.getScore(), sut.puzzleBoxArray[2][1]?.getScore())
        XCTAssertEqual(expectedResult[2][2]?.getScore(), sut.puzzleBoxArray[2][2]?.getScore())
    }
    
    func test_moveToUp_정상작동테스트() throws {
        
        let sut = GameScreenModel(currentScore: 0, topScore: 0, puzzleBoxArray: [
            [PuzzleBoxModel(id: 3, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), nil, nil],
            [PuzzleBoxModel(id: 1, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), PuzzleBoxModel(id: 0, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,2)), nil],
            [PuzzleBoxModel(id: 4, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), nil, PuzzleBoxModel(id: 5, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1))],
        ])
        
        sut.moveToUp()
        
        let expectedResult = [
            [PuzzleBoxModel(id: 3, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), PuzzleBoxModel(id: 0, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,2)), PuzzleBoxModel(id: 5, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1))],
            [PuzzleBoxModel(id: 1, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), nil, nil],
            [PuzzleBoxModel(id: 4, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), nil, nil],
        ]
        
        XCTAssertEqual(expectedResult, sut.puzzleBoxArray)
        
    }
    
    func test_increaseCurrentScore_정상작동테스트() throws {
        
        let sut = GameScreenModel(currentScore: 0, topScore: 0, puzzleBoxArray: [[nil]])
        
        sut.increaseCurrentScore(plus: 10)
        
        XCTAssertEqual(sut.currentScore, 10)
    }
    
    func test_setTopScore_정상작동테스트() throws {
        
        let sut = GameScreenModel(currentScore: 0, topScore: 2, puzzleBoxArray: [[nil]])
        
        sut.setTopScore(score: 5)
        
        XCTAssertEqual(sut.topScore, 5)
    }
}
