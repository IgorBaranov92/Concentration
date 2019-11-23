import UIKit

class ConcentrationViewController: UIViewController, ConcentrationGameDelegate {
   
    private var theme: (emoji:String,backgroundColor:UIColor,cardColor:UIColor)!
    private lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count/3)
    private var currentEmoji = String()
    private var selectedCards: [UIButton] {
        cardButtons.filter { $0.currentTitle != "" && !$0.isHidden }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNewGame()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateStackView()
    }

    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            if !game.cards[cardIndex].isMatched && cardButtons[cardIndex].currentTitle == "" {
                cardButtons[cardIndex].isUserInteractionEnabled = false
                game.chooseCard(at: cardIndex)
                cardButtons[cardIndex].setTitle(buttonTitle(game.cards[cardIndex].identifier),
                                                for: .normal)
                UIView.transition(with: cardButtons[cardIndex],
                                  duration: Constants.durationForFlippingCard,
                                  options: .transitionFlipFromLeft,
                                  animations: {
                                    self.cardButtons[cardIndex].backgroundColor = .clear
                })
                if selectedCards.count == 3 {
                    enableUI(false)
                }
                updateLabels()
            }
        }
    }

    private func buttonTitle(_ id:Int) -> String {
        return String(currentEmoji[currentEmoji.index(currentEmoji.startIndex, offsetBy: id)])
    }

    @IBAction func newGame(_ sender: UIButton) {
        createNewGame()
    }

    @objc private func createNewGame() {
        game = Concentration(numberOfPairsOfCards: cardButtons.count/3)
        game.delegate = self
        theme = Array(themes.values)[Int.random(in: 0..<themes.count)]
        currentEmoji = theme.emoji
        cardButtons.forEach { $0.backgroundColor = theme.cardColor
                              $0.setTitle("", for: .normal)
                              $0.isUserInteractionEnabled = true
                              $0.titleLabel?.adjustsFontSizeToFitWidth = true
        }
        view.backgroundColor = theme.backgroundColor
        scoreLabel.text = NSLocalizedString("Scores", comment: "") + "\(Concentration.scores)"
        scoreLabel.textColor = theme.cardColor
        newGameButton.setTitleColor(theme.cardColor, for: .normal)
    }


    private func updateLabels() {
        scoreLabel.text = NSLocalizedString("Scores", comment: "") + "\(Concentration.scores)"
    }
    

    private func enableUI(_ isUserInteractionEnabled:Bool) {
        cardButtons.forEach { $0.isUserInteractionEnabled = isUserInteractionEnabled }
    }

    
    private let themes : [String:(emoji:String,cardColor:UIColor,backgroundColor:UIColor)] = [
        "Halloween":
         ("🤡😈👿👹👺💀☠️👻👽👾🤖🦇🦉🕷🕸🥀🍫🍬🍭🎃🔮🎭🕯🗡⛓⚰️⚱️",#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
        "Sport" : ("⚽⚾🏀🏐🏈🏉⛹🤾🥎🏏🏑🏒🥅🥍🏓🎾🏸🥊🥋🤺🤼🏃🏇🏋🏹🤸🤹🛹🥏🎳🏊🏄🤽🎿⛸⛷🏂🛷🥌🏌⛳🧭⛺🎣🧗",#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)) ,
        "Transport" :
            ("✈️⛵🚤🚣🚀🚁🚂🚊🚅🚃🚎🚌🚍🚙🚘🚗🚕🚖🚛🚚🚓🚔🚒🚑🚐🚲🚡🚟🚠🚜", #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)),
        "Animal": ("🐶🐺🐱🐭🐹🐰🐸🐯🐨🐻🐷🐮🐗🐵🐒🐴🐑🐘🐼🐧🐦🐤🐥🐣🐔🐍🐢🐛🐝🐜🐞🐌🐙🐚🐠🐟🐬🐳🐋🐄🐏🐀🐃🐅🐇🐉🐎🐐🐓🐕🐖🐁🐂🐲🐡🐊🐫🐪🐆🐈🐩",#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1),#colorLiteral(red: 0.8306297664, green: 1, blue: 0.7910112419, alpha: 1)) ,
        "Food":("☕🍵🍶🍼🍺🍻🍸🍹🍷🍴🍕🍔🍟🍗🍖🍝🍛🍤🍱🍣🍥🍙🍘🍚🍜🍲🍢🍡🍳🍞🍩🍮🍦🍨🍧🎂🍰🍪🍫🍬🍭🍯",#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1) ),
        "Clothes"
            : ("🎩👑👒👟👞👡👠👢👕👔👚👗🎽👖👘👙💼👜👝👛👓🎀🌂💄",#colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.7650054947, blue: 0.8981300767, alpha: 1)),
        "Objects"
            : ("🔧⚒⛏🔩⚙🧲⚖💎💰📡⏰☎🔑🗝🧪🧬💊🧸📦✏🔗📐🔒📍✂",#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),#colorLiteral(red: 0.9678710938, green: 0.9678710938, blue: 0.9678710938, alpha: 1))
    ]
    
   func matchWasFound() {
        flipBackSelectedCards(matchFound: true)
    }
       
    func matchWasNotFound() {
        flipBackSelectedCards(matchFound: false)
    }
       
    private func flipBackSelectedCards(matchFound:Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.selectedCards.forEach { cardButton in
                UIView.transition(with: cardButton,
                                  duration: Constants.durationForFlippingCard,
                                  options: .transitionFlipFromLeft,
                                  animations: {
                                    cardButton.setTitle("", for: .normal)
                                    cardButton.backgroundColor = matchFound ? self.theme.backgroundColor : self.theme.cardColor
                                }) { completed in
                                    self.enableUI(true)
                                    if self.game.gameCompleted {
                                        self.perform(#selector(self.createNewGame),
                                                     with: nil,
                                               afterDelay: 1.0)
                                    }
                                }
            }
        }
    }
    
    private func updateStackView() {
          if traitCollection.verticalSizeClass == .regular && traitCollection.horizontalSizeClass == .regular {
              if isPotraitOrientation {
                  stackView.axis = .vertical
                  for subView in stackView.subviews {
                      if let subStackView = subView as? UIStackView {
                          subStackView.axis = .horizontal
                      }
                  }
              }
              if isLandscapeOrientation {
                  stackView.axis = .horizontal
                  for subView in stackView.subviews {
                      if let subStackView = subView as? UIStackView {
                          subStackView.axis = .vertical
                      }
                  }
              }
          }

      }
    
    private lazy var cardButtons: [UIButton] = {
        var buttons = [UIButton]()
        for subview in view.subviews {
            if let stackView = subview as? UIStackView {
                for stackViewSubview in stackView.subviews {
                    if let subStackView = stackViewSubview as? UIStackView,!subStackView.isHidden {
                        for button in subStackView.subviews {
                            if let gameButton = button as? UIButton,!gameButton.isHidden {
                                buttons.append(gameButton)
                            }
                        }
                    }
                }
            }
        }
        return buttons.filter { $0.isHidden == false }
    }()
}


fileprivate struct Constants {
    static let durationForFlippingCard = 0.4
    static let durationForDisappearingCard = 0.3
    static let leadingConstraintInPortrait:CGFloat = 60.0
    static let timeInterval =  0.15
    static let timeIntervalForCreatingNewGame = 1.5
}

