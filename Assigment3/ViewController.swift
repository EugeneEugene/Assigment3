import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var playingTableOutlet: PlayingTableView!
    @IBOutlet weak var addCardsButton: UIButton!
    @IBOutlet weak var scoreLabel: UIButton!
    
    var cardViewsOnTable = [CardView]()
    var chosenCardViews = [CardView]()
    
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
            let cardView = CardView(frame: playingTableOutlet.grid[i]!)
            cardView.color = card.color
            cardView.number = card.number
            cardView.shape = card.shape
            cardView.shading = card.shading
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onImageTapped))
            cardView.addGestureRecognizer(tapGestureRecognizer)
            playingTableOutlet.addSubview(cardView)
            cardViewsOnTable.append(cardView)
            setGame.cardsOnTable.append(card)
        }
        playingTableOutlet.setNeedsDisplay()
    }
    
    func updateViewFromModel() {
        for cardView in cardViewsOnTable {
            if chosenCardViews.contains(cardView) {
                cardView.layer.borderWidth = 2
                cardView.layer.borderColor = UIColor.blue.cgColor
            }
            else {
                cardView.layer.borderWidth = 0
                cardView.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    func getCardFromView(cardView: CardView) -> Card {
        return Card(put: cardView.shape, times: cardView.number, apply: cardView.shading, paint: cardView.color)
    }
    
    func deleteChosenCardViews() {
        for cardView in chosenCardViews {
            cardView.isHidden = true
        }
    }
    
    @objc func onImageTapped(sender: UITapGestureRecognizer) {
        if let selcetedView = sender.view {
            if let cardView = selcetedView as? CardView {
                let chosenCard = getCardFromView(cardView: cardView)
                if chosenCardViews.count == 3 {
                    if setGame.areMakeASet() {
                        deleteChosenCardViews()
//                        addCard3Test()
                    }
                    chosenCardViews.removeAll()
                    setGame.chosenCards.removeAll()
                    chosenCardViews.append(cardView)
                    setGame.chosenCards.append(chosenCard)
                }
                else {
                    if chosenCardViews.contains(cardView) {
                        if let indexToRemove = chosenCardViews.index(of: cardView) {
                            chosenCardViews.remove(at: indexToRemove)
                            setGame.chosenCards.remove(at: indexToRemove)
                        }
                    }
                    else {
                        
                        chosenCardViews.append(cardView)
                        setGame.chosenCards.append(chosenCard)
                    }
                }
            }
        }
        updateViewFromModel()
    }
    
//    func addCard3Test() {
//        let countOfColumn = playingTableOutlet.grid.dimensions.columnCount
//        let countOfRow = playingTableOutlet.grid.dimensions.rowCount
//        playingTableOutlet.grid = Grid(layout: .dimensions(rowCount: countOfRow, columnCount: countOfColumn), frame: playingTableOutlet.grid.frame)
//        var cardsToAdd = [Card]()
//        for _ in 0...2 {
//            cardsToAdd.append(deck.remove(at: 0))
//        }
//        addCardsTOView(cards: cardsToAdd)
//        playingTableOutlet.setNeedsDisplay()
//        playingTableOutlet.setNeedsLayout()
//    }
    
    
    
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
