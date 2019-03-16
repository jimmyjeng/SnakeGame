//
//  SnakeManager.swift
//  Snake
//
//  Created by Jimmy on 2019/3/9.
//  Copyright © 2019年 Jimmy. All rights reserved.
//

import Foundation

let BOARD_MIN_WIDTH = 5
let BOARD_MIN_HEIGHT = 10
let SNAKE_MIN_LENGTH = 3
let BOARD_MAX_WIDTH = 50
let BOARD_MAX_HEIGHT = 100
let SNAKE_MAX_LENGTH = 10
let SPEED_LEVEL = 3

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
    func speedChange(speed: Int)
    func gameFinish(score: Int)
}

class SnakeManager {
    static let shared = SnakeManager()
    weak var delegate:SnakeDelegate?
    private var body = [Point]()
    private var direction:Direction = .up
    private var food:Point?
    private var initLength = 3
    private var boardWidth:Int = 0
    private var boardHeight:Int = 0
    private var score:Int = 0
    private var speed:Int = 1
    
    
    func setBoardData(width:Int, height:Int, snakeLenght:Int) -> Bool {
        guard width >= BOARD_MIN_WIDTH && width <= BOARD_MAX_WIDTH
            && height >= BOARD_MIN_HEIGHT && height <= BOARD_MAX_HEIGHT
            && snakeLenght >= SNAKE_MIN_LENGTH && snakeLenght <= SNAKE_MAX_LENGTH else {
            print("### setBoard Error")
            return false
        }
        
        boardWidth = width
        boardHeight = height
        initLength = snakeLenght
        direction = .up
        score = 0
        speed = 1
        body = [Point]()
        for i in 0..<snakeLenght {
            body.append(Point(x: boardWidth / 2, y: boardHeight / 2 + i))
        }
        return true
    }
    
    func getBoardSize() -> (Int, Int){
        return (boardWidth, boardHeight)
    }

    func getBody() -> [Point]{
        return body
    }
    
    func getFood() -> Point? {
        return food
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
            delegate?.gameFinish(score: score)
        } else if (body.contains(where: {$0.x == headPoint.x && $0.y == headPoint.y})) {
            delegate?.gameFinish(score: score)
        } else if (headPoint.x == food?.x && headPoint.y == food?.y) {
            score += 1
            let newSpeed = adjustSpeed(score: score)
            if (newSpeed != speed) {
                speed = newSpeed
                delegate?.speedChange(speed: newSpeed)
            }
            body.insert(headPoint, at: 0)
            generateFood()
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
    
    func generateFood() {
        guard (body.count < boardWidth * boardHeight) else {
            delegate?.gameFinish(score: score)
            return
        }
        let x = Int.random(in: 0..<boardWidth)
        let y = Int.random(in: 0..<boardHeight)
        let foodPoint = Point(x: x, y: y)
        if (body.contains(where: {$0.x == foodPoint.x && $0.y == foodPoint.y})) {
            generateFood()
        } else {
            food = foodPoint
        }
    }
    
    func adjustSpeed(score:Int) -> Int {
        return (score / SPEED_LEVEL) + 1
    }
    
    func getSpeed() -> Int {
        return speed
    }
    
}
