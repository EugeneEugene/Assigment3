import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var playingTableOutlet: PlayingTableView!
    @IBOutlet weak var score: UIButton!
    var deck = DeckOfCards().deck
    
//    var countOfCells
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deck = DeckOfCards().deck
        deck.shuffle()
        addCardsTOView(cards: deck)
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        for view in playingTableOutlet.subviews {
            if let cardView = view as? CardView {
                cardView.removeFromSuperview()
            }
        }
        deck = DeckOfCards().deck
        deck.shuffle()
        playingTableOutlet.grid = Grid(layout: .dimensions(rowCount: 9, columnCount: 3), frame: playingTableOutlet.grid.frame)
        addCardsTOView(cards: deck)
    }
    
    func addCardsTOView(cards: Array<Card>) {
        var cardsToShow = cards
        for i in playingTableOutlet.subviews.count..<playingTableOutlet.grid.cellCount {
            let card = cardsToShow.remove(at: 0)
            let cardView = CardView(frame: playingTableOutlet.grid[i]!.zoom(by: 0.85))
            cardView.color = card.color
            cardView.number = card.number
            cardView.shape = card.shape
            cardView.shading = card.shading
            playingTableOutlet.addSubview(cardView)
        }
        playingTableOutlet.setNeedsDisplay()
    }
    
    @IBAction func addThreeCards(_ sender: UIButton) {
        if deck.count >= 3{
            let countOfColumn = playingTableOutlet.grid.dimensions.columnCount
            let countOfRow = playingTableOutlet.grid.dimensions.rowCount + 1
            playingTableOutlet.grid = Grid(layout: .dimensions(rowCount: countOfRow, columnCount: countOfColumn), frame: playingTableOutlet.grid.frame)
            var cardsToAdd = [Card]()
            for _ in 0...2 {
                cardsToAdd.append(deck.remove(at: 0))
            }
            addCardsTOView(cards: cardsToAdd)
            playingTableOutlet.setNeedsDisplay()
        }
        else {
            sender.isEnabled = false
        }
    }
}






