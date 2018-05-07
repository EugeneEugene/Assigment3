//
//  PlayingTableView.swift
//  
//
//  Created by eugene on 03/05/2018.
//

import UIKit

class PlayingTableView: UIView {
    lazy var grid = Grid(layout: .dimensions(rowCount: 9, columnCount: 3), frame: self.bounds)
    
    override func draw(_ rect: CGRect) {
        grid.frame = self.bounds
        var i = 0
        for view in self.subviews {
            if let cardView = view as? CardView {
                cardView.frame = grid[i]!
                i+=1
                cardView.setNeedsDisplay()
            }
        }
    }
}

extension CGRect {
    func zoom(by zoomFactor: CGFloat) -> CGRect {
        let zoomedWidth = size.width * zoomFactor
        let zoomedHeight = size.height * zoomFactor
        let originX = origin.x + (size.width - zoomedWidth) / 2
        let originY = origin.y + (size.height - zoomedHeight) / 2
        return CGRect(origin: CGPoint(x: originX,y: originY) , size: CGSize(width: zoomedWidth, height: zoomedHeight))
    }
}
