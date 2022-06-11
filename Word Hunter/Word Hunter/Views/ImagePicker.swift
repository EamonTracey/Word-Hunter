//
//  ImagePicker.swift
//  Word Hunter
//
//  Created by Eamon Tracey.
//

import Foundation
import PhotosUI
import SwiftUI
import Vision

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var uiImage: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        // Only allow images
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let pickerViewController = PHPickerViewController(configuration: config)
        pickerViewController.delegate = context.coordinator
        
        return pickerViewController
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        //
    }
}

extension ImagePicker {
    class Coordinator: PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            provider.loadObject(ofClass: UIImage.self) { image, _ in
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        self.parent.uiImage = image
                    }
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}
