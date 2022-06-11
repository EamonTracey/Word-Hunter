//
//  Board+Vision.swift
//  Word Hunter
//
//  Created by Eamon Tracey.
//

import Foundation
import Vision
import UIKit

extension Board {
    init?(from cgImage: CGImage) {
        if let str = Board.stringFromImage(cgImage: cgImage) {
            self.init(from: str)
        } else {
            return nil
        }
    }
}

extension Board {
    // Read characters off an image of a Word Hunt board
    private static func stringFromImage(cgImage: CGImage) -> String? {
        var croppedImage: CGImage! = nil
        
        // Create vision request handler for cgImage
        let originalHandler = VNImageRequestHandler(cgImage: cgImage)
        
        // Request rectangles in cgImage
        let rectanglesRequest = VNDetectRectanglesRequest() { request, _ in
            if let rects = request.results as? [VNRectangleObservation] {
                // Find the largest detected rectangle
                // We hope this is the rectangle encapsulating the board
                if let largestRect = rects.max(by: { r1, r2 in
                    // Determine largest rectangle by computing areas
                    let a1 = (r1.topRight.x - r1.topLeft.x) * (r1.topLeft.y - r1.bottomLeft.y)
                    let a2 = (r2.topRight.x - r2.topLeft.x) * (r2.topLeft.y - r2.bottomLeft.y)
                    return a1 < a2
                }) {
                    // Crop our image to the largest rectangle
                    croppedImage = cgImage.cropping(to: CGRect(
                        x: largestRect.bottomLeft.x * cgImage.width,
                        y: largestRect.bottomLeft.y * cgImage.height,
                        width: (largestRect.topRight.x - largestRect.topLeft.x) * cgImage.width,
                        height: (largestRect.topLeft.y - largestRect.bottomLeft.y) * cgImage.height
                    ))
                }
            }
        }
        
        // Perform rectangles request
        try? originalHandler.perform([rectanglesRequest])
        
        // If unable to crop image to a rectangle, use full image for text recognition
        croppedImage = croppedImage ?? cgImage
        
        // Create vision request handler for croppedImage
        let croppedHandler = VNImageRequestHandler(cgImage: croppedImage)
        
        // Request text from cropped image
        let textRequest = VNRecognizeTextRequest()
        textRequest.recognitionLevel = .accurate
        
        // Perform text request
        try? croppedHandler.perform([textRequest])
        
        // Attempt to construct board using text results
        guard let results = textRequest.results else { return nil }

        // Extract all top candidate strings found
        let strings = results.compactMap { $0.topCandidates(1)[0].string }
        
        // Join strings, filter to ascii letters, and convert to uppercase
        let joined = strings.joined(separator: "").filter { $0.isASCII && $0.isLetter }.uppercased()
        
        return joined
    }
}

fileprivate func *(lhs: CGFloat, rhs: Int) -> CGFloat {
    return lhs * CGFloat(rhs)
}
