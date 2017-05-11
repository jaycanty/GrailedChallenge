//
//  ImageManager.swift
//  GrailedChallenge
//
//  Created by jay on 5/11/17.
//  Copyright © 2017 jay. All rights reserved.
//

import Foundation


class ImageManager {

    static let shared = ImageManager()
    
    private lazy var queue: OperationQueue = {
        let q = OperationQueue()
        q.name = "Image Queue"
        q.maxConcurrentOperationCount = 100
        return q
    }()
    let cache = NSCache<NSString, NSData>()
    
    func imageData(for urlString: String, complete: @escaping (Data?)->()) {
        queue.addOperation {
            if let data = self.cache.object(forKey: urlString as NSString) {
                complete(data as Data)
            } else if let url = URL(string: urlString) {
                do {
                    let data = try Data(contentsOf: url)
                    self.cache.setObject(data as NSData, forKey: urlString as NSString)
                    complete(data)
                } catch {
                    print(error)
                    complete(nil)
                }
            }
        }
    }
}
