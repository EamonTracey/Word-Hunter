//
//  HomeLinksView.swift
//  Word Hunter
//
//  Created by Eamon Tracey.
//

import SwiftUI

struct HomeLinksView: View {
    var body: some View {
        VStack {
            HStack {
                NavigationLink {
                    ManualView()
                } label: {
                    HomeLabel(text: "Manual", sf: "square.and.pencil", width: 150, height: 100)
                }
                NavigationLink {
                    PhotoLibraryView()
                } label: {
                    HomeLabel(text: "Photo Library", sf: "photo", width: 150, height: 100)
                }
            }
        }
        .foregroundColor(.accentColor)
    }
}
