//
//  PhotoLibraryView.swift
//  Word Hunter
//
//  Created by Eamon Tracey.
//

import SwiftUI

struct PhotoLibraryView: View {
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        VStack {
            if let uiImage = vm.uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .border(.white)
            } else {
                Rectangle()
                    .strokeBorder()
                    .overlay(
                        Text("Select a screenshot of a word hunt board. The app will attempt to recognize the characters and recreate the board.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                    )
            }
            Button("Select photo") {
                vm.imagePickerShowing = true
            }
            .font(.title)
            .font(.body)
            NavigationLink(destination: ManualView(board: vm.board), isActive: $vm.manualPushed) { EmptyView() }.hidden()
        }
        .padding()
        .navigationTitle("Photo Selection1")
        .sheet(isPresented: $vm.imagePickerShowing) {
            ImagePicker(uiImage: $vm.uiImage)
        }
        .onChange(of: vm.uiImage) {
            _ in vm.uiImageChanged()
        }
    }
}
