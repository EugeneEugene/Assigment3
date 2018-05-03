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
        deck = DeckOfCards().deck
        deck.shuffle()
        playingTableOutlet.addCardsTOView(cards: deck)
    }
}






