//
//  Character+Null.swift
//  Word Hunter
//
//  Created by Eamon Tracey.
//

import Foundation

// Null static variable
extension Character {
    static let null = Character(UnicodeScalar(0))
}

extension Character {
    var isNull: Bool {
        self == .null
    }
}
