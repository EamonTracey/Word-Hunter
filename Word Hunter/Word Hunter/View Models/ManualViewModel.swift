//
//  ManualViewModel.swift
//  Word Hunter
//
//  Created by Eamon Tracey.
//

import Foundation
import SwiftUI

extension ManualView {
    @MainActor class ViewModel: ObservableObject {
        @Published var board: Board
        
        init(board: Board) {
            self.board = board
        }
        
        func previousCell(_ cell: [Int]?) -> [Int]? {
            guard let cell = cell else { return nil }
            
            // Dismiss keyboard if at first cell
            if cell == [0, 0] {
                return nil
            }
            
            if cell[1] == 0 {
                // Move to last cell in previous row
                return [cell[0] - 1, 3]
            } else {
                // Move to previous cell in current row
                return [cell[0], cell[1] - 1]
            }
        }
        
        func nextCell(_ cell: [Int]?) -> [Int]? {
            guard let cell = cell else { return nil }
            
            // Dismiss keyboard if at last cell
            if cell == [3, 3] {
                return nil
            }

            if cell[1] == 3 {
                // Move to first cell in next row
                return [cell[0] + 1, 0]
            } else {
                // Move to next cell in current row
                return [cell[0], cell[1] + 1]
            }
        }
    }
}
