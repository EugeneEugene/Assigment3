import Foundation

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
