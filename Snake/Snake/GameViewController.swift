//
//  GameViewController.swift
//  Snake
//
//  Created by Jimmy on 2019/3/9.
//  Copyright © 2019年 Jimmy. All rights reserved.
//

import UIKit

// TODO: user input
let BOARD_WIDTH = 10
let BOARD_HEIGHT = 20
let SNAKE_LENGTH = 3

class GameViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    var checkTimer:Timer?
    var playing:Bool = false
    var boardView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpGesture()
        SnakeManager.shared.delegate = self
    }
    
    func activeTimer() {
        self.checkTimer = Timer.scheduledTimer(timeInterval: 1.0 / Double(SnakeManager.shared.getSpeed()), target: self, selector: #selector(self.tick), userInfo: nil, repeats: true)
    }
    
    func setUpGesture() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    func setUpGame() {
        let result = SnakeManager.shared.setBoardData(width: BOARD_WIDTH, height: BOARD_HEIGHT, snakeLenght: SNAKE_LENGTH)
        
        if (result) {
            SnakeManager.shared.generateFood()
            self.boardView?.setNeedsDisplay()
            playing = true
            activeTimer()
        } else {
            let alertController = UIAlertController(
                title: "Error",
                message: "Game Data Error",
                preferredStyle: .alert)
            
            let okAction = UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func onStartClicked(_ sender: Any) {
        self.boardView = BoardView(frame: CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: view.safeAreaLayoutGuide.layoutFrame.size.width, height: view.safeAreaLayoutGuide.layoutFrame.size.height))
        self.view.insertSubview(self.boardView!, at: 0)
        
        startButton.isHidden = true
        setUpGame()
    }
    
    @objc func swipeAction(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.up:
                SnakeManager.shared.changeDirection(newDirection: .up)
            case UISwipeGestureRecognizer.Direction.down:
                SnakeManager.shared.changeDirection(newDirection: .down)
            case UISwipeGestureRecognizer.Direction.left:
                SnakeManager.shared.changeDirection(newDirection: .left)
            case UISwipeGestureRecognizer.Direction.right:
                SnakeManager.shared.changeDirection(newDirection: .right)
            default:
                break
            }
        }
    }
    
    @objc func tick(timer: Timer) {
        guard playing else {
            return
        }
        self.boardView?.setNeedsDisplay()
        SnakeManager.shared.next()
    }
}

extension GameViewController: SnakeDelegate {
    func speedChange(speed: Int) {
        checkTimer?.invalidate()
        activeTimer()
    }
    
    func gameFinish(score:Int) {
        playing = false
        checkTimer?.invalidate()
        
        let alertController = UIAlertController(
            title: "Game Over",
            message: "Score:\(score)",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(
            title: "Try Again",
            style: .default,
            handler: {[weak self]
                action in
                self?.setUpGame()
        })
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
