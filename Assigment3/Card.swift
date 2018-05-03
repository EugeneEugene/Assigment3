import UIKit

struct Card: Equatable {
    let color: UIColor
    let shape: Shape
    let number: Int
    let shading: Shading
    
    init(put shape: Shape, times number: Int, apply shading: Shading, paint color: UIColor) {
        self.shape = shape
        self.number = number
        self.shading = shading
        self.color = color
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.color == rhs.color && lhs.shape == rhs.shape &&
            lhs.number == rhs.number && lhs.shading == rhs.shading
    }
    
    enum Shading {
        case Striped, Filled, Outlined
        static let all = [Shading.Striped, .Filled, .Outlined]
    }
    
    enum Number {
        static var all = [1, 2, 3]
    }
    
    enum Shape {
        case Sphere, Square, Triangle
        static let all = [Shape.Sphere, .Square, .Triangle]
    }
    
    enum Color {
        static let all = [UIColor.red, .green, .purple]
    }
    
}

