//
//  Concentration.swift
//  Concentration
//
//  Created by spongebink on 2019/1/11.
//  Copyright © 2019 spongebink. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    }
                    else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        
        // set (newValue) {
        set {
            for index in cards.indices {
//                if index == newValue {
//                    cards[index].isFaceUp = true
//                }
//                else {
//                    cards[index].isFaceUp = false
//                }
                
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
//        if cards[index].isFaceUp {
        
//            cards[index].isFaceUp = true
//        }
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfTheOneAndOnlyFaceUpCard, matchIndex != index {
                // Check if the cards match
                
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
//                indexOfTheOneAndOnlyFaceUpCard = nil
            }
            else {
                // Either no cards or 2 cards are face up
                
//                for faceDownIndex in cards.indices {
//                    cards[faceDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfTheOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numbersOfPairsOfCards: Int) {
        for _ in 0..<numbersOfPairsOfCards {
            let card = Card()
            cards += [card, card]
//            cards.append(card)
//            cards.append(card)
            
        }
        
        // TODO: Shuffle the cards
        
        for _ in 0..<20 {
            let exIndex1 = Int(arc4random_uniform(UInt32(cards.count)))
            let exIndex2 = Int(arc4random_uniform(UInt32(cards.count)))
            let ex: Card? = cards[exIndex1]
            cards[exIndex1] = cards[exIndex2]
            cards[exIndex2] = ex!

        }
    }
}
