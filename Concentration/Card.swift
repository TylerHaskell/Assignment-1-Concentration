//
//  Card.swift
//  Concentration
//
//  Created by I847323 on 2/4/20.
//  Copyright © 2020 Tyler. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false { didSet { if isFaceUp { isSeen = true }}}
    var isMatched = false
    var isSeen = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
