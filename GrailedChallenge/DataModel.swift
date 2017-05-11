//
//  DataModel.swift
//  GrailedChallenge
//
//  Created by jay on 5/10/17.
//  Copyright © 2017 jay. All rights reserved.
//

import Foundation


class DataModel {
    
    let service = DataService()
    private var pages: UInt = 2
    private var currentPage: UInt = 0 {
        didSet {
            if currentPage == 0 {
                items.removeAll()
            }
        }
    }
    private var items = [Item]()
    
    func getData(complete: @escaping (Result<[Item]>)->()) {
        if currentPage >= (pages - 1) {
            complete(.success(data: items))
            return
        }
        service.fetchListData(for: currentPage) { result in
            switch result {
            case let .error(message):
                complete(.error(message: message))
            case let .success(data):
                self.pages = data.pages
                self.items += data.items
                self.currentPage += 1
                complete(.success(data: self.items))
            }
        }
    }
    
    func reset() {
        currentPage = 0
    }
}
