//
//  SnakeManager.swift
//  Snake
//
//  Created by Jimmy on 2019/3/9.
//  Copyright © 2019年 Jimmy. All rights reserved.
//

import Foundation

enum Direction: Int {
    case up
    case down
    case left
    case right
}

struct Point {
    var x:Int
    var y:Int
}

class SnakeManager {
    static let shared = SnakeManager()
    var body = [Point]()
    var direction:Direction = .up
    var initLength = 3
    var boardWidth:Int = 0
    var boardHeight:Int = 0

    
    func setBoardSize(width:Int, height:Int, snakeLenght:Int) {
        guard width >= 5 && height >= 5 && snakeLenght >= 3 else {
            print("### setBoard Error")
            return
        }
        
        boardWidth = width
        boardHeight = height
        initLength = snakeLenght
        
        for i in 0..<snakeLenght {
            body.append(Point(x: boardWidth / 2, y: boardHeight / 2 + i))
        }
        
        for item in body {
            print("@@ body \(item.x) \(item.y)")
        }
    }

    func next() {
        var headPoint = body.first!
        switch direction {
        case .up:
            headPoint.y -= 1
        case .down:
            headPoint.y += 1
        case .left:
            headPoint.x -= 1
        case .right:
            headPoint.x += 1
        }
        body.insert(headPoint, at: 0)
        body.removeLast()
    }
    
    func changeDirection(newDirection: Direction) {
        if (direction == .up || direction == .down) {
            if (newDirection == .left || newDirection == .right) {
                direction = newDirection
            }
        } else if (direction == .left || direction == .right) {
            if (newDirection == .up || newDirection == .down) {
                direction = newDirection
            }
        }
    }
    
}
