//
//  BoardView.swift
//  Snake
//
//  Created by Rex on 2019/3/9.
//  Copyright © 2019年 Jimmy. All rights reserved.
//

import UIKit

class BoardView: UIView {
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        
        UIColor.brown.set()
        UIBezierPath(rect: rect).fill()
        let cellWidth = self.frame.width / CGFloat(SnakeManager.shared.boardWidth)
        let cellHeight = self.frame.height / CGFloat(SnakeManager.shared.boardHeight)
        
        for i in 0..<SnakeManager.shared.boardHeight {
            for j in 0..<SnakeManager.shared.boardWidth {
                let path = UIBezierPath(rect: CGRect(x: CGFloat(j) * cellWidth,   y: CGFloat(i) * cellHeight, width: cellWidth, height: cellHeight))
                UIColor.red.setStroke()
                path.stroke()
                
                let point = Point(x:j, y:i)
                if (SnakeManager.shared.body.contains(where: {$0.x == point.x && $0.y == point.y})) {
                    UIColor.black.setFill()
                    path.fill()
                } else if (SnakeManager.shared.food?.x == point.x && SnakeManager.shared.food?.y == point.y) {
                    UIColor.orange.setFill()
                    path.fill()
                }
                
            }
        }
    }
}
