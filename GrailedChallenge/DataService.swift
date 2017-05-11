//
//  DataModel.swift
//  GrailedChallenge
//
//  Created by jay on 5/9/17.
//  Copyright © 2017 jay. All rights reserved.
//

import Foundation
import AlgoliaSearch

class DataService {
    
    let formatter = DateFormatter()
    let indexName = "Listing_production"
    let client = Client(
        appID: "MNRWEFSS2Q",
        apiKey: "ce26ba82dbc20d4f25c28a2077ce159d"
    )
    var index: Index!
    
    init() {
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        index = client.index(withName: indexName)
    }

    func fetchListData(for page: UInt, complete: @escaping (Result<[Item]>)->()) {
        let query = Query()
        query.page = page
        index.search(query) { content, error in
            guard let content = content else {
                complete(.error(message: "fetching error"))
                return
            }
            let json = JJSON(content)
            var items = [Item]()
            if let hits = json["hits"] {
                for itemJson in hits {
                    if let id = itemJson["id"]?.int,
                        let createdAtString = itemJson["created_at"]?.string,
                        let date = self.formatter.date(from: createdAtString),
                        let title = itemJson["title"]?.string,
                        let desc = itemJson["description"]?.string,
                        let designerName = itemJson["designers"]?[0]?["name"]?.string,
                        let size = itemJson["size"]?.string,
                        let price = itemJson["price_i"]?.int,
                        let photoData = itemJson["cover_photo"],
                        let photoURL = photoData["url"]?.string,
                        let photoWidth = photoData["width"]?.int,
                        let photoHeight = photoData["height"]?.int {
                        let photo = Photo(
                            url: photoURL,
                            width: Float(photoWidth),
                            height: Float(photoHeight)
                        )
                        let item = Item(
                            id: id,
                            createdAt: date,
                            title: title,
                            desc: desc,
                            designerName: designerName,
                            size: size,
                            price: price,
                            photo: photo
                        )
                        items.append(item)
                    }
                }
            }
            complete(.success(data: items))
        }
    }
}
