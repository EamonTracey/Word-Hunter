//
//  Solver.swift
//  Word Hunter
//
//  Created by Eamon Tracey.
//

import Foundation

class WordHuntDictionary {
    static var words: [String] = {
        if let dictionaryURL = Bundle.main.url(forResource: "dictionary", withExtension: "txt") {
            if let contents = try? String(contentsOf: dictionaryURL) {
                return contents.split(separator: "\n").map { String($0) }
            }
        }
        return []
    }()
}
