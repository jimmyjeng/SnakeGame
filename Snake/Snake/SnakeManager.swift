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

protocol SnakeDelegate: class {
    func gameFinish () 
}

class SnakeManager {
    static let shared = SnakeManager()
    weak var delegate:SnakeDelegate?
    var body = [Point]()
    var direction:Direction = .up
    var initLength = 3
    var boardWidth:Int = 0
    var boardHeight:Int = 0

    
    func setBoardData(width:Int, height:Int, snakeLenght:Int) {
        guard width >= 5 && height >= 5 && snakeLenght >= 3 else {
            print("### setBoard Error")
            return
        }
        
        boardWidth = width
        boardHeight = height
        initLength = snakeLenght
        direction = .up
        body = [Point]()
        for i in 0..<snakeLenght {
            body.append(Point(x: boardWidth / 2, y: boardHeight / 2 + i))
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
        
        if (headPoint.x >= boardWidth || headPoint.y >= boardHeight || headPoint.x < 0 || headPoint.y < 0) {
            delegate?.gameFinish()
        } else if (body.contains(where: {$0.x == headPoint.x && $0.y == headPoint.y})) {
            delegate?.gameFinish()
        } else {
            body.insert(headPoint, at: 0)
            body.removeLast()
        }
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
