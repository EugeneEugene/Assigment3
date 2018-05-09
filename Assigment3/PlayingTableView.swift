//
//  PlayingTableView.swift
//  
//
//  Created by eugene on 03/05/2018.
//

import UIKit

class PlayingTableView: UIView {
//    lazy var grid = Grid(layout: .dimensions(rowCount: 9, columnCount: 3), frame: self.bounds.zoom(by: 0.85))
    lazy var grid = Grid(layout: .dimensions(rowCount: 9, columnCount: 3), frame: self.bounds)
    
    
    override func draw(_ rect: CGRect) {
        print("rd")
        grid.frame = self.bounds
        var i = 0
        for view in self.subviews {
            if let cardView = view as? CardView {
                cardView.frame = grid[i]!.zoom(by: 0.8)
                i+=1
                cardView.setNeedsDisplay()
                cardView.setNeedsLayout()
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
