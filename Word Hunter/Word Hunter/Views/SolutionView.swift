//
//  SolutionView.swift
//  Word Hunter
//
//  Created by Eamon Tracey.
//

import SwiftUI

struct SolutionView: View {
    @StateObject private var vm: ViewModel
    
    init(board: Board) {
        self._vm = StateObject(wrappedValue: ViewModel(board: board))
    }
    
    var body: some View {
        Group {
            if let solution = vm.solution {
                VStack {
                    Text("Number of words: \(solution.count)")
                    Text("Max Score: \(vm.maxScore)")
                    List(solution, id:\.self) { word in
                        Text(word)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle("Solution")
    }
}

struct SolutionView_Previews: PreviewProvider {
    static let previewBoard = Board(chars: [
        ["O", "D", "N", "S"],
        ["I", "I", "V", "S"],
        ["R", "O", "L", "N"],
        ["T", "O", "G", "H"]
    ])
    
    static var previews: some View {
        SolutionView(board: previewBoard)
    }
}
