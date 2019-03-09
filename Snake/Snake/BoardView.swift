//
//  BoardView.swift
//  Snake
//
//  Created by Rex on 2019/3/9.
//  Copyright © 2019年 Jimmy. All rights reserved.
//

import UIKit

class BoardView: UIView {
    var boardWidth:Int = 5
    var boardHeight:Int = 10
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        
        UIColor.brown.set()
        UIBezierPath(rect: rect).fill()
        
        let cellWidth = self.frame.width / CGFloat(boardWidth)
        let cellHeight = self.frame.height / CGFloat(boardHeight)
        
//        for i in 0..<boardHeight {
//            for j in 0..<boardWidth {
//                let path = UIBezierPath()
//                path.move(to: CGPoint(x: CGFloat(j) * cellWidth,   y: CGFloat(i) * cellHeight))
//                path.addLine(to: CGPoint(x: CGFloat(j) * cellWidth,   y: CGFloat(i + 1) * cellHeight))
//                path.addLine(to: CGPoint(x: CGFloat(j + 1) * cellWidth,   y: CGFloat(i + 1) * cellHeight))
//                path.addLine(to: CGPoint(x: CGFloat(j + 1) * cellWidth,   y: CGFloat(i) * cellHeight))
//                path.close()
//            }
//        }
        
        for i in 0..<boardHeight {
            for j in 0..<boardWidth {
            let path = UIBezierPath(rect: CGRect(x: CGFloat(j) * cellWidth,   y: CGFloat(i) * cellHeight, width: cellWidth, height: cellHeight))
                UIColor.red.setStroke()
                path.stroke()
                
                if i == 1 && j == 1 {
                    UIColor.black.setFill()
                    path.fill()
                }
                
                if i == 3 && j == 3 {
                    UIColor.blue.setFill()
                    path.fill()
                }
            }
        }
    }
}
