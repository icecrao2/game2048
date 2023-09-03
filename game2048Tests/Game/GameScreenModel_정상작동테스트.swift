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

    func test_moveToRight_정상작동테스트() throws {
        
        let sut = GameScreenModel(currentScore: 0, topScore: 0, puzzleBoxArray: [
            [nil, nil, nil],
            [PuzzleBoxModel(id: 1, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), PuzzleBoxModel(id: 0, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 2, textColor: .red, position: (1,1)), nil],
            [nil, nil, nil],
        ])
        
        sut.moveToRight()
     
        let expectedResult = [
    [nil, nil, nil],
    [nil, nil, PuzzleBoxModel(id: 0, location: CGRect(x: 0, y: 0, width: 10, height: 10), color: .white, score: 4, textColor: .red, position: (1,1))],
    [nil, nil, nil],
        ]
        
        
        XCTAssertEqual(expectedResult[0][1]?.getScore(), sut.puzzleBoxArray[0][1]?.getScore())
        XCTAssertEqual(expectedResult[0][2]?.getScore(), sut.puzzleBoxArray[0][2]?.getScore())
    }
}
