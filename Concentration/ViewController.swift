//
//  ViewController.swift
//  Concentration
//
//  Created by I847323 on 1/15/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            flipCountLabel.text = "Flips: \(game.flipCount)"
            scoreLabel.text = "Score: \(game.score)"
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.restart()
        emojiChoices = themes[themes.count.randomNumber]
        game.flipCount = 0
        game.score = 0
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var themes = [
    ["🦇","😱","🙀","😈","🎃","👻","🍭","🍬","🍎"],
    ["⚾️","🏀","🏈","⚽️","🏒","⛳️","🏂","🥌","🎾"],
    ["🍍","🍔","🥨","🌮","🍕","🍣","🍤","🍪","🍝"],
    ["🐶","🐭","🦊","🐻","🦁","🐸","🐽","🐵","🐔"],
    ["🚗","🚕","🚙","🚌","🏎","🚓","🚛","🚒","🚑"],
    ["⌚️","📱","💻","🖥","💾","📀","📺","☎️","📻",]]
    
    lazy var emojiChoices = themes[themes.count.randomNumber]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

}

extension Int {
    var randomNumber: Int {
        switch self {
        case 1...Int.max:
            return Int(arc4random_uniform(UInt32(self)))
        case -Int.max..<0:
            return Int(arc4random_uniform(UInt32(self)))
        default:
            return 0
        }
    }
}
