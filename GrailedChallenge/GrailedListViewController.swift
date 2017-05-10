//
//  GrailedListViewController.swift
//  GrailedChallenge
//
//  Created by jay on 5/9/17.
//  Copyright © 2017 jay. All rights reserved.
//

import UIKit

class GrailedListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let model = DataModel()
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getItems() {
        model.getData() { result in
            switch result {
            case .error(_):
                // TODO: show error
                break
            case let .success(data):
                self.items = data
            }
        }
    }
}


extension GrailedListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GrailedCollectionViewCell", for: indexPath) as! GrailedCollectionViewCell
        return cell
    }
}
 
