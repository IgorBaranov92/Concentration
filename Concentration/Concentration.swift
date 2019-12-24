import Foundation

class Concentration {
    
    weak var delegate: ConcentrationGameDelegate?
    static private(set) var scores = 0
    private(set) var cards = [Card]()
    
    var gameCompleted: Bool { cards.filter { $0.isMatched }.count == cards.count }
    var selectedCards: [Card] { cards.filter { $0.isFaceUp } }
    
    private var cardsAreMatched: Bool {
        Set(selectedCards.map {Int($0.identifier)}).count == 1
    }
    
    private var penalty: Int { selectedCards.filter { $0.alreadySeen == true }.count }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            cards[index].isFaceUp = true
            if selectedCards.count == 3 {
                if cardsAreMatched {
                    Concentration.scores += 3
                    setCardsMatched()
                    delegate?.matchWasFound()
                } else {
                    Concentration.scores -= penalty
                    delegate?.matchWasNotFound()
                }
                flipBackCards()
            }
        }

    }

    private func flipBackCards() {
        for index in cards.indices {
            if cards[index].isFaceUp {
                cards[index].isFaceUp = false
                cards[index].alreadySeen = true
            }
        }
    }
    
    private func setCardsMatched() {
        for index in cards.indices {
            if cards[index].isFaceUp {
                cards[index].isMatched = true
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for id in 1...numberOfPairsOfCards {
            let card = Card(id: id)
            cards += [card,card,card]
        }
        cards = cards.shuffled()
    }
    
}
