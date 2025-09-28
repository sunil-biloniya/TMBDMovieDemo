//
//  ImageCache.swift
//  TMBDMovieDemo
//
//  Created by sunil biloniya on 28/09/25.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func saveImage(_ key: String, _ image: UIImage) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func getImage(_ key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
