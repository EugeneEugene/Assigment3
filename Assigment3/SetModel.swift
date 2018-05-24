import UIKit
import GameKit

struct SetModel {
    
    var matchedCards = [Card]()
    var cards = [Card]()
    var cardsOnTable = [Card]()
    var chosenCards = [Card]()
    
    private let numbers = Card.Number.all
    private let colors = [UIColor]()
    private let shapes = [Card.Shape]()
    private let shadings = [Card.Shading]()
    
    var deck = [Card]()
    
    init() {
        for shape in Card.Shape.all {
            for count in Card.Number.all {
                for color in Card.Color.all {
                    for shading in Card.Shading.all {
                        deck.append(Card(put: shape, times: count, apply: shading, paint: color))
                    }
                }
            }
        }
    }
    
    internal func areMakeASet() -> Bool {
        let firstCard = chosenCards[0]
        let secondCard = chosenCards[1]
        let thirdCard = chosenCards[2]
        
        let colors = [firstCard.color, secondCard.color, thirdCard.color]
        let shapes = [firstCard.shape, secondCard.shape, thirdCard.shape]
        let numbers = [firstCard.number, secondCard.number, thirdCard.number]
        let shadings = [firstCard.shading, secondCard.shading, thirdCard.shading]
        
        let uniqueColors = Array(Set(colors))
        let uniqueShapes = Array(Set(shapes))
        let uniqueNumbers  = Array(Set(numbers))
        let uniqueShadings = Array(Set(shadings))
        return !(uniqueColors.count == 2 || uniqueShapes.count == 2 || uniqueNumbers.count == 2 || uniqueShadings.count == 2)
    }
}

extension Array {
    mutating func shuffle() {
        self = (GKRandomSource.sharedRandom().arrayByShufflingObjects(in: self) as! Array<Element>)
    }
}

extension Int {
    func arc4random() -> Int {
        return  Int(arc4random_uniform(UInt32(self)))
    }
}
