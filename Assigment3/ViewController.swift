import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var playingTableOutlet: PlayingTableView!
    @IBOutlet weak var addCardsButton: UIButton!
    @IBOutlet weak var scoreLabel: UIButton!
    
    var setGame = SetModel()
    lazy var deck = setGame.deck
    var listOfChosenCardView = [CardView]()

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
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onImageTapped))
            cardView.addGestureRecognizer(tapGestureRecognizer)
            playingTableOutlet.addSubview(cardView)
            //
            setGame.cardViewsOnTable.append(cardView)
            setGame.cardsOnTable.append(card)
        }
        playingTableOutlet.setNeedsDisplay()
    }
    
    func updateViewFromModel() {
        for cardView in setGame.cardViewsOnTable {
            if setGame.chosenCardViews.contains(cardView) {
                cardView.layer.borderWidth = 2
                cardView.layer.borderColor = UIColor.blue.cgColor
            }
            else {
                cardView.layer.borderWidth = 0
                cardView.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    @objc func onImageTapped(sender: UITapGestureRecognizer) {
        if let selcetedView = sender.view {
            if let cardView = selcetedView as? CardView {
                if setGame.chosenCardViews.count == 3 {
                    setGame.chosenCardViews.removeAll()
                    setGame.chosenCardViews.append(cardView)
                }
                else {
                    if setGame.chosenCardViews.contains(cardView) {
                        if let indexToRemove = setGame.chosenCardViews.index(of: cardView) {
                            setGame.chosenCardViews.remove(at: indexToRemove)
                        }
                    }
                    else {
                        setGame.chosenCardViews.append(cardView)
                    }
                }
            }
        }
        updateViewFromModel()
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






