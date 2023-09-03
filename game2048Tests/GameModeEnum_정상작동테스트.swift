//
//  메인화면_GameModeEnum_정상작동테스트.swift
//  game2048Tests
//
//  Created by sw on 2023/09/03.
//

import XCTest
@testable import game2048

final class GameModeEnum_테스트: XCTestCase {
    
    override func setUpWithError() throws {
    
    }
    
    override func tearDownWithError() throws {
        
    }
    
    
    func test_GameModeEnum_next메서드_테스트() throws {
     
        let gameModeEnum: GameModeEnum = .ThreeOnThree
        
        let expectedResult: GameModeEnum = .FourOnFour
        let result = gameModeEnum.next()
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_GameModeEnum_next메서드_끝부분에서_처음으로_돌아가는지_테스트() throws {
     
        let gameModeEnum: GameModeEnum = .EightOnEight
        
        let expectedResult: GameModeEnum = .ThreeOnThree
        let result = gameModeEnum.next()
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_GameModeEnum_previouse메서드_테스트() throws {
     
        let gameModeEnum: GameModeEnum = .FourOnFour
        
        let expectedResult: GameModeEnum = .ThreeOnThree
        let result = gameModeEnum.previous()
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_GameModeEnum_previouse메서드_끝부분에서_마지막으로_돌아가는지_테스트() throws {
     
        let gameModeEnum: GameModeEnum = .ThreeOnThree
        
        let expectedResult: GameModeEnum = .EightOnEight
        let result = gameModeEnum.previous()
        
        XCTAssertEqual(result, expectedResult)
    }
}
