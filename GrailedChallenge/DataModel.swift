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
    
    private var currentPage: UInt = 1 {
        didSet {
            if currentPage == 1 {
                items.removeAll()
            }
        }
    }
    private var items = [Item]()
    
    func getData(complete: @escaping (Result<[Item]>)->()) {
        service.fetchListData(for: currentPage) { result in
            switch result {
            case .error(_):
                complete(result)
            case let .success(data):
                self.items += data
                // TODO: get max page and check
                self.currentPage += 1
                complete(.success(data: self.items))
            }
        }
    }
}
