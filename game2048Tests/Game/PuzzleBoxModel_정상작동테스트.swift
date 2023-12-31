//
//  PuzzleBoxModel_정상작동테스트.swift
//  game2048Tests
//
//  Created by sw on 2023/09/03.
//

import XCTest
import SwiftUI
@testable import game2048

final class PuzzleBoxModel_정상작동테스트: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
   
    
    
    func test_equatable_작동테스트() throws {
        
        let uuid = UUID()
        
        let sut = PuzzleBoxModel(id: uuid,location: CGRect(x: 0, y: 0, width: 0, height: 0), color: ViewConst.boxColors[2]!, score: 2, textColor: .white, position: (0,0))
        let tester = PuzzleBoxModel(id: uuid, location: CGRect(x: 0, y: 0, width: 0, height: 0), color: ViewConst.boxColors[2]!, score: 2, textColor: .white, position: (0,0))
        
        
        XCTAssertEqual(sut, tester)
    }
    
    func test_increase_메서드_작동테스트() throws {
        
        let sut = PuzzleBoxModel( location: CGRect(x: 0, y: 0, width: 0, height: 0), color: ViewConst.boxColors[2]!, score: 2, textColor: .white, position: (0,0))
        
        sut.increase()
        let expectedResult = PuzzleBoxModel(location: CGRect(x: 0, y: 0, width: 0, height: 0), color: ViewConst.boxColors[4]!, score: 4, textColor: .white, position: (0,0))
        
        
        XCTAssertEqual(expectedResult.color, sut.color)
        XCTAssertEqual(expectedResult.score, sut.score)
    }

    
    func test_move_메서드_작동테스트() throws {
        
        let sut = PuzzleBoxModel(location: CGRect(x: 0, y: 0, width: 0, height: 0), color: ViewConst.boxColors[2]!, score: 2, textColor: .white, position: (0,0))
        
        sut.move(to: CGRect(x: 10, y: 10, width: 10, height: 10))
        let expectedResult = PuzzleBoxModel(location: CGRect(x: 10, y: 10, width: 10, height: 10), color: ViewConst.boxColors[4]!, score: 4, textColor: .white, position: (0,0))
        
        
        XCTAssertEqual(expectedResult.location, sut.location)
    }
    
    func test_setPosition_메서드_작동테스트() throws {
        
        GameScreenModel.gameScreenRect = CGRect(x: 0, y: 0, width: 30, height: 30)
        PuzzleBoxModel.map = (3, 3)
        
        let sut = PuzzleBoxModel(location: CGRect(x: 0, y: 0, width: 0, height: 0), color: ViewConst.boxColors[2]!, score: 2, textColor: .white, position: (0,0))
        GameScreenModel.gameScreenRect = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        
        
        sut.setPosition(position: (1, 1))
        
        
        
        XCTAssertEqual(sut.position.0, 1)
        XCTAssertEqual(sut.position.1, 1)
        XCTAssertEqual(sut.location, CGRect(x: 10, y: 10, width: 10, height: 10))
        
    }
    
}
