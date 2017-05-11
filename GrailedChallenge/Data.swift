//
//  Item.swift
//  GrailedChallenge
//
//  Created by jay on 5/9/17.
//  Copyright © 2017 jay. All rights reserved.
//

import Foundation


struct Item {

    var id: Int
    var createdAt: Date
    var title: String
    var desc: String
    var designerName: String
    var size: String
    var price: Int
    var photo: Photo
}


struct Photo {
    
    var url: String
    var width: Float
    var height: Float
}
