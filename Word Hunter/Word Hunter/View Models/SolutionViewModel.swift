//
//  SolutionViewModel.swift
//  Word Hunter
//
//  Created by Eamon Tracey.
//

import Foundation

extension SolutionView {
    @MainActor class ViewModel: ObservableObject {
        var board: Board
        @Published var solution: [String]?
        
        init(board: Board) {
            self.board = board
            
            assignSolution()
        }
        
        var maxScore: Int! {
            solution?.map { word in
                [3: 100, 4: 400, 5: 800, 6: 1400, 7: 1800, 8: 2200, 9: 2600, 10: 3000, 11: 3400, 12: 3800, 13: 4200, 14: 4600, 15: 5000, 16: 5400][word.count]!
            }.reduce(0, +)
        }
        
        private func assignSolution() {
            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {
                    self.solution = self.board.solution
                }
            }
        }
    }
}
