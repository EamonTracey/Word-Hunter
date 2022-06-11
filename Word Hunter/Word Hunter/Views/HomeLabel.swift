//
//  HomeLabel.swift
//  Word Hunter
//
//  Created by Eamon Tracey.
//

import SwiftUI

struct HomeLabel: View {
    let text: String
    let sf: String
    let width: CGFloat?
    let height: CGFloat?
    
    var body: some View {
        HStack {
            Image(systemName: sf)
            Text(text)
        }
        .frame(width: width, height: height)
        .border(TintShapeStyle())
    }
}
