import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var alreadySeen = false
    private(set) var identifier: Int
    
    init(id:Int) {
        self.identifier = id
    }
}

extension Card: Hashable {
    static func ==(lhs:Card,rhs:Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
