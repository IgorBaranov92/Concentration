import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var numberOfMismatchedInvolded = -1
    private(set) var identifier: Int
    static private var id = 1
    
    init() {
        identifier = Card.id
        Card.id += 1
    }
}

extension Card: Hashable {
    static func ==(lhs:Card,rhs:Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
}
