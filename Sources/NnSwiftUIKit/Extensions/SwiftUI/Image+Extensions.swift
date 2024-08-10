//
//  Image+Extensions.swift
//
//
//  Created by Nikolai Nobadi on 1/10/24.
//

import SwiftUI

/// Extension for Image to provide additional utility methods.
public extension Image {
    /// An enum representing different types of images (system or media).
    enum ImageType {
        case system(String)
        case media(String, Bundle?)
    }
    
    /// Initializes an Image using the specified ImageType.
    /// - Parameter imageType: The type of image to initialize (system or media).
    init(imageType: ImageType) {
        switch imageType {
        case .system(let imageName):
            self.init(systemName: imageName)
        case .media(let imageName, let bundle):
            self.init(imageName, bundle: bundle)
        }
    }
}

