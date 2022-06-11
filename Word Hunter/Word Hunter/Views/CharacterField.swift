//
//  CharacterField.swift
//  Word Hunter
//
//  Created by Eamon Tracey.
//

import SwiftUI

struct CharacterField: View {
    @StateObject private var vm: ViewModel
    private var titleKey: LocalizedStringKey
    
    init(_ titleKey: LocalizedStringKey, char: Binding<Character>) {
        self._vm = StateObject(wrappedValue: ViewModel(char: char))
        self.titleKey = titleKey
    }
    
    var body: some View {
        TextField(titleKey, text: $vm.text)
            .disableAutocorrection(true)
            .onChange(of: vm.text) { _ in
                vm.textChanged()
            }
    }
}
