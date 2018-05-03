import Foundation
import GameplayKit

struct DeckOfCards {
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
