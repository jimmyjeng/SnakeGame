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
        let (boardWidth, boardHeight) = SnakeManager.shared.getBoardSize()
        let cellWidth = self.frame.width / CGFloat(boardWidth)
        let cellHeight = self.frame.height / CGFloat(boardHeight)
        
        for i in 0..<boardHeight {
            for j in 0..<boardWidth {
                let path = UIBezierPath(rect: CGRect(x: CGFloat(j) * cellWidth,   y: CGFloat(i) * cellHeight, width: cellWidth, height: cellHeight))
                UIColor.red.setStroke()
                path.stroke()
                
                let point = Point(x:j, y:i)
                if (SnakeManager.shared.getBody().contains(where: {$0.x == point.x && $0.y == point.y})) {
                    UIColor.black.setFill()
                    path.fill()
                } else if (SnakeManager.shared.getFood()?.x == point.x && SnakeManager.shared.getFood()?.y == point.y) {
                    UIColor.orange.setFill()
                    path.fill()
                }
                
            }
        }
    }
}
