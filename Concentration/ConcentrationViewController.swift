//
//  ViewController.swift
//  Concentration
//
//  Created by spongebink on 2019/1/10.
//  Copyright © 2019 spongebink. All rights reserved.
//

import UIKit

class ConcentrationViewController: VCLLoggingViewController {
    
    override var vclLoggingName: String {
        return "Game"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        flipCountLabel.text = traitCollection.verticalSizeClass == .compact ? "Flips:\n\(flipCount)" : "Flips: \(flipCount)"
    }
    
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            newGame()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var  visibleCardButtons: [UIButton]! {
        return cardButtons?.filter { !$0.superview!.isHidden }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        // flipCard(withemoji: "🎃", on: sender)
        if sender.currentTitle == "" || sender.currentTitle == nil {
            if let cardNumberforCount = visibleCardButtons.index(of: sender) {
                if game.cards[cardNumberforCount].isMatched == false {
                    flipCount += 1
                }
            }
        }
        if let cardNumber = visibleCardButtons.index(of: sender) {
            // print("cardnumber = \(cardNumber)")
            // flipCard(withemoji: emojiChoices[cardNumber], on: sender)
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        // flipClountLabel.text = "Flips: \(flipCount)"
    }
    
    //    @IBAction func touchSecondCard(_ sender: UIButton) {
    //        flipCard(withemoji: "👻", on: sender)
    //        flipCount += 1
    //    }
    
    private func newGame() {
        flipCount = 0
        
        for button in cardButtons {
            //            print(card.currentTitle!)
            //            if card.currentTitle != "" || card.currentTitle != nil {
            //                card.setTitle("", for: UIControl.State.normal)
            //                card.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            //            }
            button.setTitle("", for: UIControl.State.normal)
        }
        for index in game.cards.indices {
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
        }
        
        for _ in 0..<20{
            let exIndex1 = Int(arc4random_uniform(UInt32(game.cards.count)))
            let exIndex2 = Int(arc4random_uniform(UInt32(game.cards.count)))
            let ex: Card? = game.cards[exIndex1]
            game.cards[exIndex1] = game.cards[exIndex2]
            game.cards[exIndex2] = ex!
        }
        
        emojiChoices = ["🦇", "😂", "👠", "🍭", "🍬", "🍫", "🍪", "🤩", "😈", "🤖", "🎃", "👻", "🍙", "🍩", "☕️" ,"⚽️"]
        // emojiChoices = ["🤩","😈","🤖","🎃","👻","💩","👌","🤭","🤫","😲","🤬","😠","👀","🍎","💂‍♂️","🐏","🌱","☘️","💐","🌸","🌚","🌝","🍄","🌹","🌏","🌈","🔥","❄️","🌮","🍕","🌶","🍙","🍩","☕️","⚽️","🎱","🏐","⛳️","🏈","🎽","🥇","🚕","🚁",]
        
        // emojiChoices = ["🤩","😈","🤖","🎃","👻","💩","👌","🤭"]
        
        //        for _ in 0..<emoji.count {
        //            emoji.removeValue(forKey: 1)
        //        }
        emoji = [:]
        
        updateViewFromModel()
    }


    private lazy var game: Concentration = Concentration(numbersOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        // get {
        return (visibleCardButtons.count + 1) / 2
        // }
    }
    
    private(set) var flipCount = 0 {
        didSet {
            if let textToSet: String? = traitCollection.verticalSizeClass == .compact ? "Flips:\n\(flipCount)" : "Flips: \(flipCount)" {
                flipCountLabel.text = textToSet
            }
        }
    }

//    private let allEmojiChoices = ["😀","😁","😂","🤣","😃","😄","😅","😆","😉","😊","😋","😎","😍","😘","🥰","😗","😙","😚","☺️","🙂","🤗","🤩","🤔","🤨","😐","😑","😶","🙄","😏","😣","😥","😮","🤐","😯","😪","😫","😴","😌","😛","😜","😝","🤤","😒","😓","😔","😕","🙃","🤑","😲","☹️","🙁","😖","😞","😟","😤","😢","😭","😦","😧","😨","😩","🤯","😬","😰","😱","🥵","🥶","😳","🤪","😵","😡","😠","🤬","😷","🤒","🤕","🤢","🤮","🤧","😇","🤠","🤡","🥳","🥴","🥺","🤥","🤫","🤭","🧐","🤓","😈","👿","👹","👺","💀","👻","👽","🤖","💩","😺","😸","😹","😻","😼","😽","🙀","😿","😾","👶","👧","🧒","👦","👩","🧑","👨","👵","🧓","👴","👲","👳‍♀️","👳‍♂️","🧕","🧔","👱‍♂️","👱‍♀️","👨‍🦰","👩‍🦰","👨‍🦱","👩‍🦱","👨‍🦲","👩‍🦲","👨‍🦳","👩‍🦳","🦸‍♀️","🦸‍♂️","🦹‍♀️","🦹‍♂️","👮‍♀️","👮‍♂️","👷‍♀️","👷‍♂️","💂‍♀️","💂‍♂️","🕵️‍♀️","🕵️‍♂️","👩‍⚕️","👨‍⚕️","👩‍🌾","👨‍🌾","👩‍🍳","👨‍🍳","👩‍🎓","👨‍🎓","👩‍🎤","👨‍🎤","👩‍🏫","👨‍🏫","👩‍🏭","👨‍🏭","👩‍💻","👨‍💻","👩‍💼","👨‍💼","👩‍🔧","👨‍🔧","👩‍🔬","👨‍🔬","👩‍🎨","👨‍🎨","👩‍🚒","👨‍🚒","👩‍✈️","👨‍✈️","👩‍🚀","👨‍🚀","👩‍⚖️","👨‍⚖️","👰","🤵","👸","🤴","🤶","🎅","🧙‍♀️","🧙‍♂️","🧝‍♀️","🧝‍♂️","🧛‍♀️","🧛‍♂️","🧟‍♀️","🧟‍♂️","🧞‍♀️","🧞‍♂️","🧜‍♀️","🧜‍♂️","🧚‍♀️","🧚‍♂️","👼","🤰","🤱","🙇‍♀️","🙇‍♂️","💁‍♀️","💁‍♂️","🙅‍♀️","🙅‍♂️","🙆‍♀️","🙆‍♂️","🙋‍♀️","🙋‍♂️","🤦‍♀️","🤦‍♂️","🤷‍♀️","🤷‍♂️","🙎‍♀️","🙎‍♂️","🙍‍♀️","🙍‍♂️","💇‍♀️","💇‍♂️","💆‍♀️","💆‍♂️","🧖‍♀️","🧖‍♂️","💅","🤳","💃","🕺","👯‍♀️","👯‍♂️","🕴","🚶‍♀️","🚶‍♂️","🏃‍♀️","🏃‍♂️","👫","👭","👬","💑","👩‍❤️‍👩","👨‍❤️‍👨","💏","👩‍❤️‍💋‍👩","👨‍❤️‍💋‍👨","👪","👨‍👩‍👧","👨‍👩‍👧‍👦","👨‍👩‍👦‍👦","👨‍👩‍👧‍👧","👩‍👩‍👦","👩‍👩‍👧","👩‍👩‍👧‍👦","👩‍👩‍👦‍👦","👩‍👩‍👧‍👧","👨‍👨‍👦","👨‍👨‍👧","👨‍👨‍👧‍👦","👨‍👨‍👦‍👦","👨‍👨‍👧‍👧","👩‍👦","👩‍👧","👩‍👧‍👦","👩‍👦‍👦","👩‍👧‍👧","👨‍👦","👨‍👧","👨‍👧‍👦","👨‍👦‍👦","👨‍👧‍👧","🤲","👐","🙌","👏","🤝","👍","👎","👊","✊","🤛","🤜","🤞","✌️","🤟","🤘","👌","👈","👉","👆","👇","☝️","✋","🤚","🖐","🖖","👋","🤙","💪","🦵","🦶","🖕","✍️","🙏","💍","💄","💋","👄","👅","👂","👃","👣","👁","👀","🧠","🦴","🦷","🗣","👤","👥","🧥","👚","👕","👖","👔","👗","👙","👘","👠","👡","👢","👞","👟","🥾","🥿","🧦","🧤","🧣","🎩","🧢","👒","🎓","⛑","👑","👝","👛","👜","💼","🎒","👓","🕶","🥽","🥼","🌂","🧵","🧶","👶🏻","👦🏻","👧🏻","👨🏻","👩🏻","👱🏻‍♀️","👱🏻","👴🏻","👵🏻","👲🏻","👳🏻‍♀️","👳🏻","👮🏻‍♀️","👮🏻","👷🏻‍♀️","👷🏻","💂🏻‍♀️","💂🏻","🕵🏻‍♀️","🕵🏻","👩🏻‍⚕️","👨🏻‍⚕️","👩🏻‍🌾","👨🏻‍🌾","👩🏻‍🍳","👨🏻‍🍳","👩🏻‍🎓","👨🏻‍🎓","👩🏻‍🎤","👨🏻‍🎤","👩🏻‍🏫","👨🏻‍🏫","👩🏻‍🏭","👨🏻‍🏭","👩🏻‍💻","👨🏻‍💻","👩🏻‍💼","👨🏻‍💼","👩🏻‍🔧","👨🏻‍🔧","👩🏻‍🔬","👨🏻‍🔬","👩🏻‍🎨","👨🏻‍🎨","👩🏻‍🚒","👨🏻‍🚒","👩🏻‍✈️","👨🏻‍✈️","👩🏻‍🚀","👨🏻‍🚀","👩🏻‍⚖️","👨🏻‍⚖️","🤶🏻","🎅🏻","👸🏻","🤴🏻","👰🏻","🤵🏻","👼🏻","🤰🏻","🙇🏻‍♀️","🙇🏻","💁🏻","💁🏻‍♂️","🙅🏻","🙅🏻‍♂️","🙆🏻","🙆🏻‍♂️","🙋🏻","🙋🏻‍♂️","🤦🏻‍♀️","🤦🏻‍♂️","🤷🏻‍♀️","🤷🏻‍♂️","🙎🏻","🙎🏻‍♂️","🙍🏻","🙍🏻‍♂️","💇🏻","💇🏻‍♂️","💆🏻","💆🏻‍♂️","🕴🏻","💃🏻","🕺🏻","🚶🏻‍♀️","🚶🏻","🏃🏻‍♀️","🏃🏻","🤲🏻","👐🏻","🙌🏻","👏🏻","🙏🏻","👍🏻","👎🏻","👊🏻","✊🏻","🤛🏻","🤜🏻","🤞🏻","✌🏻","🤟🏻","🤘🏻","👌🏻","👈🏻","👉🏻","👆🏻","👇🏻","☝🏻","✋🏻","🤚🏻","🖐🏻","🖖🏻","👋🏻","🤙🏻","💪🏻","🖕🏻","✍🏻","🤳🏻","💅🏻","👂🏻","👃🏻","👶🏼","👦🏼","👧🏼","👨🏼","👩🏼","👱🏼‍♀️","👱🏼","👴🏼","👵🏼","👲🏼","👳🏼‍♀️","👳🏼","👮🏼‍♀️","👮🏼","👷🏼‍♀️","👷🏼","💂🏼‍♀️","💂🏼","🕵🏼‍♀️","🕵🏼","👩🏼‍⚕️","👨🏼‍⚕️","👩🏼‍🌾","👨🏼‍🌾","👩🏼‍🍳","👨🏼‍🍳","👩🏼‍🎓","👨🏼‍🎓","👩🏼‍🎤","👨🏼‍🎤","👩🏼‍🏫","👨🏼‍🏫","👩🏼‍🏭","👨🏼‍🏭","👩🏼‍💻","👨🏼‍💻","👩🏼‍💼","👨🏼‍💼","👩🏼‍🔧","👨🏼‍🔧","👩🏼‍🔬","👨🏼‍🔬","👩🏼‍🎨","👨🏼‍🎨","👩🏼‍🚒","👨🏼‍🚒","👩🏼‍✈️","👨🏼‍✈️","👩🏼‍🚀","👨🏼‍🚀","👩🏼‍⚖️","👨🏼‍⚖️","🤶🏼","🎅🏼","👸🏼","🤴🏼","👰🏼","🤵🏼","👼🏼","🤰🏼","🙇🏼‍♀️","🙇🏼","💁🏼","💁🏼‍♂️","🙅🏼","🙅🏼‍♂️","🙆🏼","🙆🏼‍♂️","🙋🏼","🙋🏼‍♂️","🤦🏼‍♀️","🤦🏼‍♂️","🤷🏼‍♀️","🤷🏼‍♂️","🙎🏼","🙎🏼‍♂️","🙍🏼","🙍🏼‍♂️","💇🏼","💇🏼‍♂️","💆🏼","💆🏼‍♂️","🕴🏼","💃🏼","🕺🏼","🚶🏼‍♀️","🚶🏼","🏃🏼‍♀️","🏃🏼","🤲🏼","👐🏼","🙌🏼","👏🏼","🙏🏼","👍🏼","👎🏼","👊🏼","✊🏼","🤛🏼","🤜🏼","🤞🏼","✌🏼","🤟🏼","🤘🏼","👌🏼","👈🏼","👉🏼","👆🏼","👇🏼","☝🏼","✋🏼","🤚🏼","🖐🏼","🖖🏼","👋🏼","🤙🏼","💪🏼","🖕🏼","✍🏼","🤳🏼","💅🏼","👂🏼","👃🏼","👶🏽","👦🏽","👧🏽","👨🏽","👩🏽","👱🏽‍♀️","👱🏽","👴🏽","👵🏽","👲🏽","👳🏽‍♀️","👳🏽","👮🏽‍♀️","👮🏽","👷🏽‍♀️","👷🏽","💂🏽‍♀️","💂🏽","🕵🏽‍♀️","🕵🏽","👩🏽‍⚕️","👨🏽‍⚕️","👩🏽‍🌾","👨🏽‍🌾","👩🏽‍🍳","👨🏽‍🍳","👩🏽‍🎓","👨🏽‍🎓","👩🏽‍🎤","👨🏽‍🎤","👩🏽‍🏫","👨🏽‍🏫","👩🏽‍🏭","👨🏽‍🏭","👩🏽‍💻","👨🏽‍💻","👩🏽‍💼","👨🏽‍💼","👩🏽‍🔧","👨🏽‍🔧","👩🏽‍🔬","👨🏽‍🔬","👩🏽‍🎨","👨🏽‍🎨","👩🏽‍🚒","👨🏽‍🚒","👩🏽‍✈️","👨🏽‍✈️","👩🏽‍🚀","👨🏽‍🚀","👩🏽‍⚖️","👨🏽‍⚖️","🤶🏽","🎅🏽","👸🏽","🤴🏽","👰🏽","🤵🏽","👼🏽","🤰🏽","🙇🏽‍♀️","🙇🏽","💁🏽","💁🏽‍♂️","🙅🏽","🙅🏽‍♂️","🙆🏽","🙆🏽‍♂️","🙋🏽","🙋🏽‍♂️","🤦🏽‍♀️","🤦🏽‍♂️","🤷🏽‍♀️","🤷🏽‍♂️","🙎🏽","🙎🏽‍♂️","🙍🏽","🙍🏽‍♂️","💇🏽","💇🏽‍♂️","💆🏽","💆🏽‍♂️","🕴🏼","💃🏽","🕺🏽","🚶🏽‍♀️","🚶🏽","🏃🏽‍♀️","🏃🏽","🤲🏽","👐🏽","🙌🏽","👏🏽","🙏🏽","👍🏽","👎🏽","👊🏽","✊🏽","🤛🏽","🤜🏽","🤞🏽","✌🏽","🤟🏽","🤘🏽","👌🏽","👈🏽","👉🏽","👆🏽","👇🏽","☝🏽","✋🏽","🤚🏽","🖐🏽","🖖🏽","👋🏽","🤙🏽","💪🏽","🖕🏽","✍🏽","🤳🏽","💅🏽","👂🏽","👃🏽","👶🏾","👦🏾","👧🏾","👨🏾","👩🏾","👱🏾‍♀️","👱🏾","👴🏾","👵🏾","👲🏾","👳🏾‍♀️","👳🏾","👮🏾‍♀️","👮🏾","👷🏾‍♀️","👷🏾","💂🏾‍♀️","💂🏾","🕵🏾‍♀️","🕵🏾","👩🏾‍⚕️","👨🏾‍⚕️","👩🏾‍🌾","👨🏾‍🌾","👩🏾‍🍳","👨🏾‍🍳","👩🏾‍🎓","👨🏾‍🎓","👩🏾‍🎤","👨🏾‍🎤","👩🏾‍🏫","👨🏾‍🏫","👩🏾‍🏭","👨🏾‍🏭","👩🏾‍💻","👨🏾‍💻","👩🏾‍💼","👨🏾‍💼","👩🏾‍🔧","👨🏾‍🔧","👩🏾‍🔬","👨🏾‍🔬","👩🏾‍🎨","👨🏾‍🎨","👩🏾‍🚒","👨🏾‍🚒","👩🏾‍✈️","👨🏾‍✈️","👩🏾‍🚀","👨🏾‍🚀","👩🏾‍⚖️","👨🏾‍⚖️","🤶🏾","🎅🏾","👸🏾","🤴🏾","👰🏾","🤵🏾","👼🏾","🤰🏾","🙇🏾‍♀️","🙇🏾","💁🏾","💁🏾‍♂️","🙅🏾","🙅🏾‍♂️","🙆🏾","🙆🏾‍♂️","🙋🏾","🙋🏾‍♂️","🤦🏾‍♀️","🤦🏾‍♂️","🤷🏾‍♀️","🤷🏾‍♂️","🙎🏾","🙎🏾‍♂️","🙍🏾","🙍🏾‍♂️","💇🏾","💇🏾‍♂️","💆🏾","💆🏾‍♂️","🕴🏾","💃🏾","🕺🏾","🚶🏾‍♀️","🚶🏾","🏃🏾‍♀️","🏃🏾","🤲🏾","👐🏾","🙌🏾","👏🏾","🙏🏾","👍🏾","👎🏾","👊🏾","✊🏾","🤛🏾","🤜🏾","🤞🏾","✌🏾","🤟🏾","🤘🏾","👌🏾","👈🏾","👉🏾","👆🏾","👇🏾","☝🏾","✋🏾","🤚🏾","🖐🏾","🖖🏾","👋🏾","🤙🏾","💪🏾","🖕🏾","✍🏾","🤳🏾","💅🏾","👂🏾","👃🏾","👶🏿","👦🏿","👧🏿","👨🏿","👩🏿","👱🏿‍♀️","👱🏿","👴🏿","👵🏿","👲🏿","👳🏿‍♀️","👳🏿","👮🏿‍♀️","👮🏿","👷🏿‍♀️","👷🏿","💂🏿‍♀️","💂🏿","🕵🏿‍♀️","🕵🏿","👩🏿‍⚕️","👨🏿‍⚕️","👩🏿‍🌾","👨🏿‍🌾","👩🏿‍🍳","👨🏿‍🍳","👩🏿‍🎓","👨🏿‍🎓","👩🏿‍🎤","👨🏿‍🎤","👩🏿‍🏫","👨🏿‍🏫","👩🏿‍🏭","👨🏿‍🏭","👩🏿‍💻","👨🏿‍💻","👩🏿‍💼","👨🏿‍💼","👩🏿‍🔧","👨🏿‍🔧","👩🏿‍🔬","👨🏿‍🔬","👩🏿‍🎨","👨🏿‍🎨","👩🏿‍🚒","👨🏿‍🚒","👩🏿‍✈️","👨🏿‍✈️","👩🏿‍🚀","👨🏿‍🚀","👩🏿‍⚖️","👨🏿‍⚖️","🤶🏿","🎅🏿","👸🏿","🤴🏿","👰🏿","🤵🏿","👼🏿","🤰🏿","🙇🏿‍♀️","🙇🏿","💁🏿","💁🏿‍♂️","🙅🏿","🙅🏿‍♂️","🙆🏿","🙆🏿‍♂️","🙋🏿","🙋🏿‍♂️","🤦🏿‍♀️","🤦🏿‍♂️","🤷🏿‍♀️","🤷🏿‍♂️","🙎🏿","🙎🏿‍♂️","🙍🏿","🙍🏿‍♂️","💇🏿","💇🏿‍♂️","💆🏿","💆🏿‍♂️","🕴🏿","💃🏿","🕺🏿","🚶🏿‍♀️","🚶🏿","🏃🏿‍♀️","🏃🏿","🤲🏿","👐🏿","🙌🏿","👏🏿","🙏🏿","👍🏿","👎🏿","👊🏿","✊🏿","🤛🏿","🤜🏿","🤞🏿","✌🏿","🤟🏿","🤘🏿","👌🏿","👈🏿","👉🏿","👆🏿","👇🏿","☝🏿","✋🏿","🤚🏿","🖐🏿","🖖🏿","👋🏿","🤙🏿","💪🏿","🖕🏿","✍🏿","🤳🏿","💅🏿","👂🏿","👃🏿","🐶","🐱","🐭","🐹","🐰","🦊","🦝","🐻","🐼","🦘","🦡","🐨","🐯","🦁","🐮","🐷","🐽","🐸","🐵","🙈","🙉","🙊","🐒","🐔","🐧","🐦","🐤","🐣","🐥","🦆","🦢","🦅","🦉","🦚","🦜","🦇","🐺","🐗","🐴","🦄","🐝","🐛","🦋","🐌","🐚","🐞","🐜","🦗","🕷","🕸","🦂","🦟","🦠","🐢","🐍","🦎","🦖","🦕","🐙","🦑","🦐","🦀","🐡","🐠","🐟","🐬","🐳","🐋","🦈","🐊","🐅","🐆","🦓","🦍","🐘","🦏","🦛","🐪","🐫","🦙","🦒","🐃","🐂","🐄","🐎","🐖","🐏","🐑","🐐","🦌","🐕","🐩","🐈","🐓","🦃","🕊","🐇","🐁","🐀","🐿","🦔","🐾","🐉","🐲","🌵","🎄","🌲","🌳","🌴","🌱","🌿","☘️","🍀","🎍","🎋","🍃","🍂","🍁","🍄","🌾","💐","🌷","🌹","🥀","🌺","🌸","🌼","🌻","🌞","🌝","🌛","🌜","🌚","🌕","🌖","🌗","🌘","🌑","🌒","🌓","🌔","🌙","🌎","🌍","🌏","💫","⭐️","🌟","✨","⚡️","☄️","💥","🔥","🌪","🌈","☀️","🌤","⛅️","🌥","☁️","🌦","🌧","⛈","🌩","🌨","❄️","☃️","⛄️","🌬","💨","💧","💦","☔️","☂️","🌊","🌫","🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈","🍒","🍑","🍍","🥭","🥥","🥝","🍅","🍆","🥑","🥦","🥒","🥬","🌶","🌽","🥕","🥔","🍠","🥐","🍞","🥖","🥨","🥯","🧀","🥚","🍳","🥞","🥓","🥩","🍗","🍖","🌭","🍔","🍟","🍕","🥪","🥙","🌮","🌯","🥗","🥘","🥫","🍝","🍜","🍲","🍛","🍣","🍱","🥟","🍤","🍙","🍚","🍘","🍥","🥮","🥠","🍢","🍡","🍧","🍨","🍦","🥧","🍰","🎂","🍮","🍭","🍬","🍫","🍿","🧂","🍩","🍪","🌰","🥜","🍯","🥛","🍼","☕️","🍵","🥤","🍶","🍺","🍻","🥂","🍷","🥃","🍸","🍹","🍾","🥄","🍴","🍽","🥣","🥡","🥢","⚽️","🏀","🏈","⚾️","🥎","🏐","🏉","🎾","🥏","🎱","🏓","🏸","🥅","🏒","🏑","🥍","🏏","⛳️","🏹","🎣","🥊","🥋","🎽","⛸","🥌","🛷","🛹","🎿","⛷","🏂","🏋️‍♀️","🏋🏻‍♀️","🏋🏼‍♀️","🏋🏽‍♀️","🏋🏾‍♀️","🏋🏿‍♀️","🏋️‍♂️","🏋🏻‍♂️","🏋🏼‍♂️","🏋🏽‍♂️","🏋🏾‍♂️","🏋🏿‍♂️","🤼‍♀️","🤼‍♂️","🤸‍♀️","🤸🏻‍♀️","🤸🏼‍♀️","🤸🏽‍♀️","🤸🏾‍♀️","🤸🏿‍♀️","🤸‍♂️","🤸🏻‍♂️","🤸🏼‍♂️","🤸🏽‍♂️","🤸🏾‍♂️","🤸🏿‍♂️","⛹️‍♀️","⛹🏻‍♀️","⛹🏼‍♀️","⛹🏽‍♀️","⛹🏾‍♀️","⛹🏿‍♀️","⛹️‍♂️","⛹🏻‍♂️","⛹🏼‍♂️","⛹🏽‍♂️","⛹🏾‍♂️","⛹🏿‍♂️","🤺","🤾‍♀️","🤾🏻‍♀️","🤾🏼‍♀️","🤾🏾‍♀️","🤾🏾‍♀️","🤾🏿‍♀️","🤾‍♂️","🤾🏻‍♂️","🤾🏼‍♂️","🤾🏽‍♂️","🤾🏾‍♂️","🤾🏿‍♂️","🏌️‍♀️","🏌🏻‍♀️","🏌🏼‍♀️","🏌🏽‍♀️","🏌🏾‍♀️","🏌🏿‍♀️","🏌️‍♂️","🏌🏻‍♂️","🏌🏼‍♂️","🏌🏽‍♂️","🏌🏾‍♂️","🏌🏿‍♂️","🏇","🏇🏻","🏇🏼","🏇🏽","🏇🏾","🏇🏿","🧘‍♀️","🧘🏻‍♀️","🧘🏼‍♀️","🧘🏽‍♀️","🧘🏾‍♀️","🧘🏿‍♀️","🧘‍♂️","🧘🏻‍♂️","🧘🏼‍♂️","🧘🏽‍♂️","🧘🏾‍♂️","🧘🏿‍♂️","🏄‍♀️","🏄🏻‍♀️","🏄🏼‍♀️","🏄🏽‍♀️","🏄🏾‍♀️","🏄🏿‍♀️","🏄‍♂️","🏄🏻‍♂️","🏄🏼‍♂️","🏄🏽‍♂️","🏄🏾‍♂️","🏄🏿‍♂️","🏊‍♀️","🏊🏻‍♀️","🏊🏼‍♀️","🏊🏽‍♀️","🏊🏾‍♀️","🏊🏿‍♀️","🏊‍♂️","🏊🏻‍♂️","🏊🏼‍♂️","🏊🏽‍♂️","🏊🏾‍♂️","🏊🏿‍♂️","🤽‍♀️","🤽🏻‍♀️","🤽🏼‍♀️","🤽🏽‍♀️","🤽🏾‍♀️","🤽🏿‍♀️","🤽‍♂️","🤽🏻‍♂️","🤽🏼‍♂️","🤽🏽‍♂️","🤽🏾‍♂️","🤽🏿‍♂️","🚣‍♀️","🚣🏻‍♀️","🚣🏼‍♀️","🚣🏽‍♀️","🚣🏾‍♀️","🚣🏿‍♀️","🚣‍♂️","🚣🏻‍♂️","🚣🏼‍♂️","🚣🏽‍♂️","🚣🏾‍♂️","🚣🏿‍♂️","🧗‍♀️","🧗🏻‍♀️","🧗🏼‍♀️","🧗🏽‍♀️","🧗🏾‍♀️","🧗🏿‍♀️","🧗‍♂️","🧗🏻‍♂️","🧗🏼‍♂️","🧗🏽‍♂️","🧗🏾‍♂️","🧗🏿‍♂️","🚵‍♀️","🚵🏻‍♀️","🚵🏼‍♀️","🚵🏽‍♀️","🚵🏾‍♀️","🚵🏿‍♀️","🚵‍♂️","🚵🏻‍♂️","🚵🏼‍♂️","🚵🏽‍♂️","🚵🏾‍♂️","🚵🏿‍♂️","🚴‍♀️","🚴🏻‍♀️","🚴🏼‍♀️","🚴🏽‍♀️","🚴🏾‍♀️","🚴🏿‍♀️","🚴‍♂️","🚴🏻‍♂️","🚴🏼‍♂️","🚴🏽‍♂️","🚴🏾‍♂️","🚴🏿‍♂️","🏆","🥇","🥈","🥉","🏅","🎖","🏵","🎗","🎫","🎟","🎪","🤹‍♀️","🤹🏻‍♀️","🤹🏼‍♀️","🤹🏽‍♀️","🤹🏾‍♀️","🤹🏿‍♀️","🤹‍♂️","🤹🏻‍♂️","🤹🏼‍♂️","🤹🏽‍♂️","🤹🏾‍♂️","🤹🏿‍♂️","🎭","🎨","🎬","🎤","🎧","🎼","🎹","🥁","🎷","🎺","🎸","🎻","🎲","🧩","♟","🎯","🎳","🎮","🎰","🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🚚","🚛","🚜","🛴","🚲","🛵","🏍","🚨","🚔","🚍","🚘","🚖","🚡","🚠","🚟","🚃","🚋","🚞","🚝","🚄","🚅","🚈","🚂","🚆","🚇","🚊","🚉","✈️","🛫","🛬","🛩","💺","🛰","🚀","🛸","🚁","🛶","⛵️","🚤","🛥","🛳","⛴","🚢","⚓️","⛽️","🚧","🚦","🚥","🚏","🗺","🗿","🗽","🗼","🏰","🏯","🏟","🎡","🎢","🎠","⛲️","⛱","🏖","🏝","🏜","🌋","⛰","🏔","🗻","🏕","⛺️","🏠","🏡","🏘","🏚","🏗","🏭","🏢","🏬","🏣","🏤","🏥","🏦","🏨","🏪","🏫","🏩","💒","🏛","⛪️","🕌","🕍","🕋","⛩","🛤","🛣","🗾","🎑","🏞","🌅","🌄","🌠","🎇","🎆","🌇","🌆","🏙","🌃","🌌","🌉","🌁","⌚️","📱","📲","💻","⌨️","🖥","🖨","🖱","🖲","🕹","🗜","💽","💾","💿","📀","📼","📷","📸","📹","🎥","📽","🎞","📞","☎️","📟","📠","📺","📻","🎙","🎚","🎛","⏱","⏲","⏰","🕰","⌛️","⏳","📡","🔋","🔌","💡","🔦","🕯","🗑","🛢","💸","💵","💴","💶","💷","💰","💳","🧾","💎","⚖️","🔧","🔨","⚒","🛠","⛏","🔩","⚙️","⛓","🔫","💣","🔪","🗡","⚔️","🛡","🚬","⚰️","⚱️","🏺","🧭","🧱","🔮","🧿","🧸","📿","💈","⚗️","🔭","🧰","🧲","🧪","🧫","🧬","🧯","🔬","🕳","💊","💉","🌡","🚽","🚰","🚿","🛁","🛀","🛀🏻","🛀🏼","🛀🏽","🛀🏾","🛀🏿","🧴","🧵","🧶","🧷","🧹","🧺","🧻","🧼","🧽","🛎","🔑","🗝","🚪","🛋","🛏","🛌","🖼","🛍","🧳","🛒","🎁","🎈","🎏","🎀","🎊","🎉","🧨","🎎","🏮","🎐","🧧","✉️","📩","📨","📧","💌","📥","📤","📦","🏷","📪","📫","📬","📭","📮","📯","📜","📃","📄","📑","📊","📈","📉","🗒","🗓","📆","📅","📇","🗃","🗳","🗄","📋","📁","📂","🗂","🗞","📰","📓","📔","📒","📕","📗","📘","📙","📚","📖","🔖","🔗","📎","🖇","📐","📏","📌","📍","✂️","🖊","🖋","✒️","🖌","🖍","📝","✏️","🔍","🔎","🔏","🔐","🔒","🔓","❤️","🧡","💛","💚","💙","💜","🖤","💔","❣️","💕","💞","💓","💗","💖","💘","💝","💟","☮️","✝️","☪️","🕉","☸️","✡️","🔯","🕎","☯️","☦️","🛐","⛎","♈️","♉️","♊️","♋️","♌️","♍️","♎️","♏️","♐️","♑️","♒️","♓️","🆔","⚛️","🉑","☢️","☣️","📴","📳","🈶","🈚️","🈸","🈺","🈷️","✴️","🆚","💮","🉐","㊙️","㊗️","🈴","🈵","🈹","🈲","🅰️","🅱️","🆎","🆑","🅾️","🆘","❌","⭕️","🛑","⛔️","📛","🚫","💯","💢","♨️","🚷","🚯","🚳","🚱","🔞","📵","🚭","❗️","❕","❓","❔","‼️","⁉️","🔅","🔆","〽️","⚠️","🚸","🔱","⚜️","🔰","♻️","✅","🈯️","💹","❇️","✳️","❎","🌐","💠","Ⓜ️","🌀","💤","🏧","🚾","♿️","🅿️","🈳","🈂️","🛂","🛃","🛄","🛅","🚹","🚺","🚼","🚻","🚮","🎦","📶","🈁","🔣","ℹ️","🔤","🔡","🔠","🆖","🆗","🆙","🆒","🆕","🆓","0️⃣","1️⃣","2️⃣","3️⃣","4️⃣","5️⃣","6️⃣","7️⃣","8️⃣","9️⃣","🔟","🔢","#️⃣","*️⃣","⏏️","▶️","⏸","⏯","⏹","⏺","⏭","⏮","⏩","⏪","⏫","⏬","◀️","🔼","🔽","➡️","⬅️","⬆️","⬇️","↗️","↘️","↙️","↖️","↕️","↔️","↪️","↩️","⤴️","⤵️","🔀","🔁","🔂","🔄","🔃","🎵","🎶","➕","➖","➗","✖️","♾","💲","💱","™️","©️","®️","〰️","➰","➿","🔚","🔙","🔛","🔝","🔜","✔️","☑️","🔘","⚪️","⚫️","🔴","🔵","🔺","🔻","🔸","🔹","🔶","🔷","🔳","🔲","▪️","▫️","◾️","◽️","◼️","◻️","⬛️","⬜️","🔈","🔇","🔉","🔊","🔔","🔕","📣","📢","👁‍🗨","💬","💭","🗯","♠️","♣️","♥️","♦️","🃏","🎴","🀄️","🕐","🕑","🕒","🕓","🕔","🕕","🕖","🕗","🕘","🕙","🕚","🕛","🕜","🕝","🕞","🕟","🕠","🕡","🕢","🕣","🕤","🕥","🕦","🕧","🏳️","🏴","🏁","🚩","🏳️‍🌈","🏴‍☠️","🇦🇫","🇦🇽","🇦🇱","🇩🇿","🇦🇸","🇦🇩","🇦🇴","🇦🇮","🇦🇶","🇦🇬","🇦🇷","🇦🇲","🇦🇼","🇦🇺","🇦🇹","🇦🇿","🇧🇸","🇧🇭","🇧🇩","🇧🇧","🇧🇾","🇧🇪","🇧🇿","🇧🇯","🇧🇲","🇧🇹","🇧🇴","🇧🇦","🇧🇼","🇧🇷","🇮🇴","🇻🇬","🇧🇳","🇧🇬","🇧🇫","🇧🇮","🇰🇭","🇨🇲","🇨🇦","🇮🇨","🇨🇻","🇧🇶","🇰🇾","🇨🇫","🇹🇩","🇨🇱","🇨🇳","🇨🇽","🇨🇨","🇨🇴","🇰🇲","🇨🇬","🇨🇩","🇨🇰","🇨🇷","🇨🇮","🇭🇷","🇨🇺","🇨🇼","🇨🇾","🇨🇿","🇩🇰","🇩🇯","🇩🇲","🇩🇴","🇪🇨","🇪🇬","🇸🇻","🇬🇶","🇪🇷","🇪🇪","🇪🇹","🇪🇺","🇫🇰","🇫🇴","🇫🇯","🇫🇮","🇫🇷","🇬🇫","🇵🇫","🇹🇫","🇬🇦","🇬🇲","🇬🇪","🇩🇪","🇬🇭","🇬🇮","🇬🇷","🇬🇱","🇬🇩","🇬🇵","🇬🇺","🇬🇹","🇬🇬","🇬🇳","🇬🇼","🇬🇾","🇭🇹","🇭🇳","🇭🇰","🇭🇺","🇮🇸","🇮🇳","🇮🇩","🇮🇷","🇮🇶","🇮🇪","🇮🇲","🇮🇱","🇮🇹","🇯🇲","🇯🇵","🎌","🇯🇪","🇯🇴","🇰🇿","🇰🇪","🇰🇮","🇽🇰","🇰🇼","🇰🇬","🇱🇦","🇱🇻","🇱🇧","🇱🇸","🇱🇷","🇱🇾","🇱🇮","🇱🇹","🇱🇺","🇲🇴","🇲🇰","🇲🇬","🇲🇼","🇲🇾","🇲🇻","🇲🇱","🇲🇹","🇲🇭","🇲🇶","🇲🇷","🇲🇺","🇾🇹","🇲🇽","🇫🇲","🇲🇩","🇲🇨","🇲🇳","🇲🇪","🇲🇸","🇲🇦","🇲🇿","🇲🇲","🇳🇦","🇳🇷","🇳🇵","🇳🇱","🇳🇨","🇳🇿","🇳🇮","🇳🇪","🇳🇬","🇳🇺","🇳🇫","🇰🇵","🇲🇵","🇳🇴","🇴🇲","🇵🇰","🇵🇼","🇵🇸","🇵🇦","🇵🇬","🇵🇾","🇵🇪","🇵🇭","🇵🇳","🇵🇱","🇵🇹","🇵🇷","🇶🇦","🇷🇪","🇷🇴","🇷🇺","🇷🇼","🇼🇸","🇸🇲","🇸🇦","🇸🇳","🇷🇸","🇸🇨","🇸🇱","🇸🇬","🇸🇽","🇸🇰","🇸🇮","🇬🇸","🇸🇧","🇸🇴","🇿🇦","🇰🇷","🇸🇸","🇪🇸","🇱🇰","🇧🇱","🇸🇭","🇰🇳","🇱🇨","🇵🇲","🇻🇨","🇸🇩","🇸🇷","🇸🇿","🇸🇪","🇨🇭","🇸🇾","🇹🇼","🇹🇯","🇹🇿","🇹🇭","🇹🇱","🇹🇬","🇹🇰","🇹🇴","🇹🇹","🇹🇳","🇹🇷","🇹🇲","🇹🇨","🇹🇻","🇻🇮","🇺🇬","🇺🇦","🇦🇪","🇬🇧","🏴󠁧󠁢󠁥󠁮󠁧󠁿","🏴󠁧󠁢󠁳󠁣󠁴󠁿","🏴󠁧󠁢󠁷󠁬󠁳󠁿","🇺🇳","🇺🇸","🇺🇾","🇺🇿","🇻🇺","🇻🇦","🇻🇪","🇻🇳","🇼🇫","🇪🇭","🇾🇪","🇿🇲","🇿🇼","🥰","🥵","🥶","🥳","🥴","🥺","👨‍🦰","👩‍🦰","👨‍🦱","👩‍🦱","👨‍🦲","👩‍🦲","👨‍🦳","👩‍🦳","🦸","🦸‍♀️","🦸‍♂️","🦹","🦹‍♀️","🦹‍♂️","🦵","🦶","🦴","🦷","🥽","🥼","🥾","🥿","🦝","🦙","🦛","🦘","🦡","🦢","🦚","🦜","🦞","🦟","🦠","🥭","🥬","🥯","🧂","🥮","🧁","🧭","🧱","🛹","🧳","🧨","🧧","🥎","🥏","🥍","🧿","🧩","🧸","♟","🧮","🧾","🧰","🧲","🧪","🧫","🧬","🧯","🧴","🧵","🧶","🧷","🧹","🧺","🧻","🧼","🧽","♾","🏴‍☠️"]
    lazy private var emojiChoices = ["🦇", "😂", "👠", "🍭", "🍬", "🍫", "🍪", "🤩", "😈", "🤖", "🎃", "👻", "🍙", "☕️" ,"⚽️"]
    // var emojiChoices = ["🤩","😈","🤖","🎃","👻","💩","👌","🤭","🤫","😲","🤬","😠","👀","🍎","💂‍♂️","🐏","🌱","☘️","💐","🌸","🌚","🌝","🍄","🌹","🌏","🌈","🔥","❄️","🌮","🍕","🌶","🍙","🍩","☕️","⚽️","🎱","🏐","⛳️","🏈","🎽","🥇","🚕","🚁",]
    
    // var emojiChoices = ["🤩","😈","🤖","🎃","👻","💩","👌","🤭"]
    
    private var emoji = [Card: String]()
    
    var theme: [String]? {
        didSet {
            emojiChoices = theme ?? []
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private func updateViewFromModel() {
        // for index in 0..<cardButtons.count{
        if visibleCardButtons != nil {
            for index in visibleCardButtons.indices {
                let button = visibleCardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                }
                else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                }
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        //        if emoji[card.identifier] != nil {
        //            return emoji[card.identifier]!
        //        }
        //        else {
        //            return "?"
        //        }
        
        if emoji[card] == nil, emojiChoices.count > 0 {
            // let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            
        }
        
        return emoji[card] ?? "?"
        
        // return "?"
    }
    
//    func flipCard(withemoji emoji: String, on button: UIButton){
//        if button.currentTitle == emoji{
//            button.setTitle("", for: UIControl.State.normal)
//            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
//        }
//        else
//        {
//            button.setTitle(emoji, for: UIControl.State.normal)
//            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        }
//    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
    }
}
