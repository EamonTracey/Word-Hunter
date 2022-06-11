//
//  HomeView.swift
//  Word Hunter
//
//  Created by Eamon Tracey.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Word Hunter")
                    .font(.largeTitle)
                    .bold()
                HomeLinksView()
            }
        }

    }
}
