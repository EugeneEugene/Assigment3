import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var playingTableOutlet: PlayingTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var deck = DeckOfCards().deck
        deck.shuffle()
        playingTableOutlet.addCardsTOView(cards: deck)
    }
}






