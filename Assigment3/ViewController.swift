import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var playingTableOutlet: PlayingTableView!
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
}






