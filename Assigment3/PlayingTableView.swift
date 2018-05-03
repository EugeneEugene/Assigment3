//
//  PlayingTableView.swift
//  
//
//  Created by eugene on 03/05/2018.
//

import UIKit

class PlayingTableView: UIView {
    //    lazy var grid = Grid(layout: .dimensions(rowCount: 1, columnCount: 1), frame: bounds)
    //    override func draw(_ rect: CGRect) {
    lazy var grid = Grid(layout: .dimensions(rowCount: 3, columnCount: 2), frame: self.bounds)
    //    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    var cards2 = Array<CardView>()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        var deck = DeckOfCards().deck
        
        for i in 0..<grid.cellCount {
            let card = deck.remove(at: 0)
            let b = UIBezierPath(rect: grid[i]!.zoom(by: 0.85))
            let cardView = CardView(frame: grid[i]!.zoom(by: 0.85))
            cardView.color = card.color
            cardView.number = card.number
            cardView.shape = card.shape
            cardView.shading = card.shading
            cardView.addConstraints(self.constraints)
            cards2.append(cardView)
            addSubview(cardView)
            UIColor.red.setFill()
            b.fill()
            
            
        }
    }
    
    override func draw(_ rect: CGRect) {
        grid.frame = self.bounds
        var deck = DeckOfCards().deck
        for i in 0..<grid.cellCount {
            cards2[i].frame = grid[i]!
            cards2[i].setNeedsDisplay()
        }
    }
}

//extension CardView {
//    private struct SizeRatio {
//        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
//        static func drawingSize(grid: Grid) -> CGFloat {
//            return grid.cellSize.height > grid.cellSize.width ? grid.cellSize.width : grid.cellSize.height
//        }
//    }
//
//    private var cornerRadius: CGFloat {
//        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
//    }
//}

extension CGRect {
    func zoom(by zoomFactor: CGFloat) -> CGRect {
        let zoomedWidth = size.width * zoomFactor
        let zoomedHeight = size.height * zoomFactor
        let originX = origin.x + (size.width - zoomedWidth) / 2
        let originY = origin.y + (size.height - zoomedHeight) / 2
        return CGRect(origin: CGPoint(x: originX,y: originY) , size: CGSize(width: zoomedWidth, height: zoomedHeight))
    }
}
