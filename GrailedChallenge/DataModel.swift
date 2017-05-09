//
//  DataModel.swift
//  GrailedChallenge
//
//  Created by jay on 5/9/17.
//  Copyright © 2017 jay. All rights reserved.
//

import Foundation
import AlgoliaSearch

class DataModel {

    let indexName = "Listing_production"
    let client = Client(
        appID: "MNRWEFSS2Q",
        apiKey: "ce26ba82dbc20d4f25c28a2077ce159d"
    )
    
    
    func fetchListData(complete: @escaping ()->()) {
        let index = client.index(withName: indexName)
        let query = Query(query: "hello")
        index.search(query) { content, error in
            complete()
        }
    }
}
