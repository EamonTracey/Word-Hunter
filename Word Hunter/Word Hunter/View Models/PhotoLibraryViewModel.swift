//
//  PhotoLibraryViewModel.swift
//  Word Hunter
//
//  Created by Eamon Tracey.
//

import Foundation
import UIKit

extension PhotoLibraryView {
    @MainActor class ViewModel: ObservableObject {
        @Published var board: Board = .empty
        @Published var imagePickerShowing = false
        @Published var uiImage: UIImage?
        @Published var manualPushed: Bool = false
        
        func uiImageChanged() {
            assignBoardFromImage()
            manualPushed = true
        }
        
        private func assignBoardFromImage() {
            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {
                    if let uiImage = self.uiImage, let cgImage = uiImage.cgImage, let board = Board(from: cgImage) {
                        self.board = board
                    }
                }
            }
        }
    }
}
