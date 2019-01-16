//
//  Card.swift
//  Concentration
//
//  Created by spongebink on 2019/1/11.
//  Copyright © 2019 spongebink. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
//        Card.identifierFactory += 1
        identifierFactory += 1
        return Card.identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
