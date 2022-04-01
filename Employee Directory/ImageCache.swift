//
//  ImageCache.swift
//  Employee Directory
//
//  Created by Randy Varela on 3/31/22.
//

import Foundation

class ImageCache {
    static let shared = ImageCache()
    private init() {}
    
    var images: [String: Data] = [:]
}
