//
//  ImageCache.swift
//  MyPhotoApp
//
//  Created by Juliano Lofy Junior on 07/02/24.
//

import Foundation

struct ImageCache {
    static let imageCache: NSCache = NSCache<NSString, NSData>()

    static func setToCache(data: Data, imageUrl: String){
        ImageCache.imageCache.setObject(data as NSData, forKey: imageUrl as NSString)
    }

    static func getFromCache(imageUrl: String) -> Data? {
        if let data = ImageCache.imageCache.object(forKey: imageUrl as NSString) {
            return data as Data
        }

        return nil
    }
}
