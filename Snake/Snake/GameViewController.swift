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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setUpGesture()
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
        print("## onStartClicked")
        playing = true
        startButton.isHidden = true
    }
    
    @objc func swipeAction(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.up:
                print("## up")
            case UISwipeGestureRecognizer.Direction.down:
                print("## down")
            case UISwipeGestureRecognizer.Direction.left:
                print("## left")
            case UISwipeGestureRecognizer.Direction.right:
                print("## right")
            default:
                break
            }
        }
    }
    
    @objc func tick(timer: Timer) {
        guard playing else {
            return
        }
        print("@@ tick")
    }

}

