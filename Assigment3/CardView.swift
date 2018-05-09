import UIKit

class CardView: UIView {
    var color = UIColor.red
    var shape = Card.Shape.Triangle
    var number = 3
    var shading = Card.Shading.Striped
    lazy var grid = Grid(layout: .dimensions(rowCount: 3, columnCount: 1), frame: bounds)
    lazy var roundedRect = UIBezierPath(roundedRect: bounds.zoom(by: 0.85), cornerRadius: cornerRadius)
    
    func test() {
        print("test")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        var figurePath = UIBezierPath()
        self.isUserInteractionEnabled = true
        
        grid.frame =  bounds.zoom(by: 0.8)
        self.backgroundColor = UIColor.yellow
        let context = UIGraphicsGetCurrentContext()
        UIColor.yellow.setFill()
        context?.fill(rect)
        roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        UIColor.white.setFill()
        roundedRect.fill()
        var grids = [CGRect]()
        switch number {
        case 1:
            grids.append(grid[1,0]!)
        case 2:
            grids.append(grid[0,0]!)
            grids.append(grid[2,0]!)
        case 3:
            grids.append(grid[0,0]!)
            grids.append(grid[1,0]!)
            grids.append(grid[2,0]!)
        default:
            assert(number<1 && number>3, "Incorrect quantity of shapes")
        }
        
        for grid1 in grids {
            switch shape {
            case .Sphere:
                figurePath = UIBezierPath(arcCenter: CGPoint(x: grid1.midX, y: grid1.midY), radius: SizeRatio.drawingSize(grid: grid)/2 , startAngle: CGFloat(0.0), endAngle: CGFloat(Double.pi*2), clockwise: true)
                UIColor.red.setFill()
            case .Square:
                let sqrSideLength = SizeRatio.drawingSize(grid: grid)
                let size = CGSize(width: sqrSideLength , height: sqrSideLength )
                let squareRect2 = CGRect(origin: CGPoint(x: grid1.midX - SizeRatio.drawingSize(grid: grid)/2, y: grid1.midY - SizeRatio.drawingSize(grid: grid)/2), size: size)
                figurePath = UIBezierPath(rect: squareRect2.zoom(by: 0.75))
                
            case .Triangle:
                figurePath.move(to: CGPoint(x: grid1.midX, y: grid1.midY - 1/4*grid1.height))
                figurePath.addLine(to: CGPoint(x: grid1.midX+1/12*grid1.width, y: grid1.midY+1/4*grid1.height))
                figurePath.addLine(to: CGPoint(x: grid1.midX-1/12*grid1.width, y: grid1.midY+1/4*grid1.height))
                figurePath.close()
            }
            
            context?.saveGState()
            figurePath.addClip()
            
            switch shading {
            case .Filled:
                color.setFill()
                figurePath.fill()
            case .Outlined:
                color.setStroke()
            case .Striped:
                var newGrid = Grid(layout:  .dimensions(rowCount: 1, columnCount: 200), frame: self.bounds)
                for i in 0..<newGrid.cellCount {
                    if i%5 == 0 {
                        let line = UIBezierPath(rect: newGrid[0,i]!)
                        color.setFill()
                        line.fill()
                    }
                }
            }
            context?.restoreGState()
            color.setStroke()
            figurePath.stroke()
        }
        
    }
}

extension CardView {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static func drawingSize(grid: Grid) -> CGFloat {
            return grid.cellSize.height > grid.cellSize.width ? grid.cellSize.width : grid.cellSize.height
        }
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
}



