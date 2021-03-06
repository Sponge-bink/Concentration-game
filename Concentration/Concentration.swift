//
//  Concentration.swift
//  Concentration
//
//  Created by spongebink on 2019/1/11.
//  Copyright © 2019 spongebink. All rights reserved.
//

import Foundation

struct Concentration {
    var cards = [Card]()
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter() { cards[$0].isFaceUp }.oneAndOnly
//            return indicesOfFaceUpCard.count == 1 ? indicesOfFaceUpCard.last : nil
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    }
//                    else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
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
    
    mutating func chooseCard(at index: Int) {
//        if cards[index].isFaceUp {
        
//            cards[index].isFaceUp = true
//        }
        
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): Chosen index not in the cards!")
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfTheOneAndOnlyFaceUpCard, matchIndex != index {
                // Check if the cards match
                
                if cards[matchIndex] == cards[index] {
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
        assert(numbersOfPairsOfCards > 0, "Concentration.init(\(numbersOfPairsOfCards)): Number of pairs of card illegal!")

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

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
