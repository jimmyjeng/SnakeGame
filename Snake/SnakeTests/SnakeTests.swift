//
//  SnakeTests.swift
//  SnakeTests
//
//  Created by Rex on 2019/3/9.
//  Copyright © 2019年 Jimmy. All rights reserved.
//

import XCTest
@testable import Snake

class SnakeTests: XCTestCase {
    let snake = SnakeManager()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSnakeSetBoard() {
        XCTAssert(snake.setBoardData(width: BOARD_MIN_WIDTH, height: BOARD_MIN_HEIGHT, snakeLenght: SNAKE_MIN_LENGTH))
        
        XCTAssert(snake.setBoardData(width: BOARD_MAX_WIDTH, height: BOARD_MAX_HEIGHT, snakeLenght: SNAKE_MAX_LENGTH))
        
        XCTAssertFalse(snake.setBoardData(width: 1, height: 1, snakeLenght: 1))
        
        XCTAssertFalse(snake.setBoardData(width: 100, height: 100, snakeLenght: 100))
    }
    
    func testSnakeAdjustSpeed() {
        XCTAssertEqual(snake.adjustSpeed(score: 1), 1)
        XCTAssertEqual(snake.adjustSpeed(score: 2), 1)
        XCTAssertEqual(snake.adjustSpeed(score: 3), 2)
        XCTAssertEqual(snake.adjustSpeed(score: 6), 3)
        XCTAssertEqual(snake.adjustSpeed(score: 10), 4)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
