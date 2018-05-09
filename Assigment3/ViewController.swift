import UIKit

class ViewController: UIViewController {
    var cardViewsOnTable = [CardView]()
    var setGame = SetModel()
    @IBOutlet weak var playingTableOutlet: PlayingTableView! 
    lazy var deck = setGame.deck
    
    @IBOutlet weak var addCardsButton: UIButton!
    @IBOutlet weak var scoreLabel: UIButton!
    
    var listOfChosenCardView = [CardView]()
    //    var countOfCells
    
    override func viewDidLoad() {
        gameInit()
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        gameInit()
    }
    
    func gameInit() {
        for view in playingTableOutlet.subviews {
            if let cardView = view as? CardView {
                cardView.removeFromSuperview()
            }
        }
        setGame = SetModel()
        deck = setGame.deck
        deck.shuffle()
        playingTableOutlet.grid = Grid(layout: .dimensions(rowCount: 9, columnCount: 3), frame: playingTableOutlet.grid.frame)
        addCardsTOView(cards: deck)
        addCardsButton.isEnabled = true
    }
    
    func addCardsTOView(cards: Array<Card>) {
        var cardsToShow = cards
        for i in playingTableOutlet.subviews.count..<playingTableOutlet.grid.cellCount {
            let card = cardsToShow.remove(at: 0)
            //            let cardView = CardView(frame: playingTableOutlet.grid[i]!.zoom(by: 0.85))
            let cardView = CardView(frame: playingTableOutlet.grid[i]!)
            cardView.color = card.color
            cardView.number = card.number
            cardView.shape = card.shape
            cardView.shading = card.shading
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onImageTapped(sender:)))
            cardView.addGestureRecognizer(tapGestureRecognizer)
            playingTableOutlet.addSubview(cardView)
            //
            cardViewsOnTable.append(cardView)
            setGame.cardsOnTable.append(card)
        }
        playingTableOutlet.setNeedsDisplay()
    }
    
    func updateViewFromModel() {
        if setGame.chosenCards.count == 3, setGame.areMakeASet() {
            //
        }
        else {
            
        }
    }
    
    @objc func onImageTapped(sender: CardView) {
        sender.test()
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






