//
//  PlayingTableView.swift
//  
//
//  Created by eugene on 03/05/2018.
//

import UIKit

class PlayingTableView: UIView {
    lazy var grid = Grid(layout: .dimensions(rowCount: 9, columnCount: 3), frame: self.bounds)
    var cardViews = Array<CardView>()
    
     func addCardsTOView(cards: Array<Card>) {
        var cardsToShow = cards
        for i in 0..<grid.cellCount {
            let card = cardsToShow.remove(at: 0)
            let cardView = CardView(frame: grid[i]!.zoom(by: 0.85))
            cardView.color = card.color
            cardView.number = card.number
            cardView.shape = card.shape
            cardView.shading = card.shading
            cardView.addConstraints(self.constraints)
            cardViews.append(cardView)
            addSubview(cardView)
        }
    }
    
    override func draw(_ rect: CGRect) {
        grid.frame = self.bounds
        for i in 0..<grid.cellCount {
            cardViews[i].frame = grid[i]!
            cardViews[i].setNeedsDisplay()
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
