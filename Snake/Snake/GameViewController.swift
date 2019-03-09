//
//  GameViewController.swift
//  Snake
//
//  Created by Jimmy on 2019/3/9.
//  Copyright © 2019年 Jimmy. All rights reserved.
//

import UIKit



class GameViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    var checkTimer:Timer?
    var playing:Bool = false
    var boardView:UIView?
    var score:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpGesture()
        SnakeManager.shared.delegate = self
        self.checkTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.tick), userInfo: nil, repeats: true)
        
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
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    
    @IBAction func onStartClicked(_ sender: Any) {
        playing = true
        startButton.isHidden = true
       
        // FIXME: check size
        SnakeManager.shared.setBoardData(width: 10, height: 20, snakeLenght: 5)
        
        self.boardView = BoardView(frame: CGRect(x: view.safeAreaInsets.left, y: view.safeAreaInsets.top, width: view.safeAreaLayoutGuide.layoutFrame.size.width, height: view.safeAreaLayoutGuide.layoutFrame.size.height))
        self.view.insertSubview(self.boardView!, at: 0)
        
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
        print("## tick")
        SnakeManager.shared.next()
        self.boardView?.setNeedsDisplay()
    }

}

extension GameViewController: SnakeDelegate {
    func gameFinish() {
        playing = false
        
        let alertController = UIAlertController(
            title: "Game Over",
            message: "Score:\(score)",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(
            title: "Try Again",
            style: .default,
            handler: {[weak self]
                action in
                SnakeManager.shared.setBoardData(width: 10, height: 20, snakeLenght: 5)
                self?.playing = true
        })
        
        alertController.addAction(okAction)
        
        // 顯示提示框
        self.present(alertController, animated: true, completion: nil)
        
    }
}
