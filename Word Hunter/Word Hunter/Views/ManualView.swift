//
//  ManualView.swift
//  Word Hunter
//
//  Created by Eamon Tracey.
//

import SwiftUI

struct ManualView: View {
    private let board: Board
    @StateObject private var vm: ViewModel
    @FocusState var focusedField: [Int]?
    
    init(board: Board = .empty) {
        self.board = board
        self._vm = StateObject(wrappedValue: ViewModel(board: board))
    }

    var body: some View {
        VStack {
            Spacer()
            ForEach(vm.board.chars.indices, id:\.self) { i in
                HStack {
                    ForEach(vm.board.chars[0].indices, id:\.self) { j in
                        CharacterField("?", char: $vm.board.chars[i][j])
                            .focused($focusedField, equals: [i, j])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.center)
                            .padding()
                            .onChange(of: vm.board.chars[i][j]) { char in
                                if !char.isNull {
                                    focusedField = vm.nextCell(focusedField)
                                }
                            }
                    }
                }
            }
            Spacer()
            NavigationLink {
                SolutionView(board: vm.board)
            } label: {
                Text("Solve")
            }
            Spacer()

        }
        .navigationTitle("Manual Entry")
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button {
                    focusedField = vm.previousCell(focusedField)
                } label: {
                    Image(systemName: "chevron.up")
                }
            }
            ToolbarItem(placement: .keyboard) {
                Button {
                    focusedField = vm.nextCell(focusedField)
                } label: {
                    Image(systemName: "chevron.down")
                }
            }
        }
    }
}
