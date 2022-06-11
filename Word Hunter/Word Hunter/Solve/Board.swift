//
//  Board.swift
//  Word Hunter
//
//  Created by Eamon Tracey.
//

import CoreGraphics
import Foundation

struct Board {
    var chars: [[Character]]
    
    // Compute all solutions
    lazy var solution: [String] = {
        WordHuntDictionary.words.filter({ word in
            contains_word(word: word)
        })
    }()
}

extension Board {
    init(from str: String) {
        var padded = str
        
        if padded.count > 16 {
            padded = String(padded.prefix(16))
        } else {
            for _ in 0..<(16 - padded.count) {
                padded += "\0"
            }
        }
        
        var iter = padded.makeIterator()
        
        self.init(
            chars: Board.empty.chars.map { $0.compactMap { _ in iter.next() } }
        )
    }
}

extension Board {
    // Create a 4x4 board of empty characters
    static let empty = Board(chars: (1...4).map { _ in (1...4).map { _ in .null } })
}

extension Board {
    // Determine if a word exists in the board
    private func contains_word(word: String, scoord: (Int, Int)? = nil) -> Bool {
        // Base case
        // Empty word indicates successful search
        if word.count == 0 {
            return true
        }
        
        // Determine a square of coordinates to search
        // If no starting coordinate is provided, the search square is the entire board
        // Otherwise, search only the square immediately surrounding the starting coordinate
        let dim = chars.count - 1
        let imin: Int, imax: Int, jmin: Int, jmax: Int
        
        if let scoord = scoord {
            imin = scoord.0 == 0 ? 0 : scoord.0 - 1
            imax = scoord.0 == dim ? dim : scoord.0 + 1
            jmin = scoord.1 == 0 ? 0 : scoord.1 - 1
            jmax = scoord.1 == dim ? dim : scoord.1 + 1
        } else {
            imin = 0
            imax = dim
            jmin = 0
            jmax = dim
        }
        
        // Loop through all coordinates of search square
        // NOTE: This contains the starting coordinate itself, but that's okay
        // because it will always equal "" and thus be ignored
        // Solution
        for i in imin...imax {
            for j in jmin...jmax {
                // If the first letter of the word matches the letter at a coordinate,
                // replace the letter at that coordinate with a blank space and recurse
                // using the word minus the first letter
                if word.first == chars[i][j] {
                    var rchars = chars
                    rchars[i][j] = .null
                    let rboard = Board(chars: rchars)
                    if rboard.contains_word(word: String(word.dropFirst(1)), scoord: (i, j)) {
                        return true
                    }
                }
            }
        }
        
        return false
    }
}
