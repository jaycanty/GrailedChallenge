//
//  Utils.swift
//  GrailedChallenge
//
//  Created by jay on 5/10/17.
//  Copyright © 2017 jay. All rights reserved.
//

import Foundation


enum Result<T> {
    case error(message: String)
    case success(data: T)
}
