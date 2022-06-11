//
//  CharacterFieldModel.swift
//  Word Hunter
//
//  Created by Eamon Tracey.
//

import Combine
import SwiftUI
import Foundation

extension CharacterField {
    @MainActor class ViewModel: ObservableObject {
        @Published var text: String
        @Binding private var char: Character
        
        init(char: Binding<Character>) {
            self.text = char.wrappedValue.isNull ? "" : String(char.wrappedValue)
            self._char = char
        }
        
        func textChanged() {
            restrictCharacter()
        }
        
        private func restrictCharacter() {
            // Force uppercase
            text = text.uppercased()
            
            // Force singular
            if text.count > 1 {
                text = String(text.prefix(1))
            }
            
            // Assign
            char = text.count == 1 ? Character(text) : .null
        }
    }
}
