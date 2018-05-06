import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var playingTableOutlet: PlayingTableView!
    @IBOutlet weak var score: UIButton!
    var deck = DeckOfCards().deck
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deck = DeckOfCards().deck
        deck.shuffle()
        playingTableOutlet.addCardsTOView(cards: deck)
    }
    @IBAction func startNewGame(_ sender: UIButton) {
        for view in playingTableOutlet.subviews {
            view.removeFromSuperview()
        }
        playingTableOutlet.cardViews.removeAll()
        deck = DeckOfCards().deck
        deck.shuffle()
        playingTableOutlet.addCardsTOView(cards: deck)
    }
    @IBAction func addThreeCards(_ sender: UIButton) {
        playingTableOutlet.grid.cellCount += 3
        playingTableOutlet.setNeedsDisplay()
        for i in 0...2  {
            let card = deck.remove(at: 0)
            var cardView = CardView()
            cardView.shape = card.shape
            cardView.number = card.number
            cardView.color = card.color
            cardView.shading = card.shading
            playingTableOutlet.addSubview(cardView)
        }
    }
}






