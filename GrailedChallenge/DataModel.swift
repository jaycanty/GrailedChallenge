//
//  DataModel.swift
//  GrailedChallenge
//
//  Created by jay on 5/10/17.
//  Copyright © 2017 jay. All rights reserved.
//

import Foundation


class DataModel {
    
    var currentPage: Int = 1

    func getData(complete: Result<[Item]>) {
        
        let service = DataService()
        
        service.fetchListData(for: currentPage) { result in
         
            
        }
    }
}
