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
        let result0 = snake.setBoardData(width: 5, height: 5, snakeLenght: 3)
        XCTAssert(result0)
        
        let result1 = snake.setBoardData(width: 1, height: 1, snakeLenght: 1)
        XCTAssertFalse(result1)
        
        let result2 = snake.setBoardData(width: 100, height: 100, snakeLenght: 100)
        XCTAssertFalse(result2)
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
