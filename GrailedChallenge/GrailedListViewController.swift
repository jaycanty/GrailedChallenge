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
    var cellWidth: CGFloat!
    var refCell: GrailedCollectionViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "GrailedCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "GrailedCollectionViewCell")
        refCell = Bundle.main.loadNibNamed("GrailedCollectionViewCell", owner: self, options: nil)!.first as! GrailedCollectionViewCell
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let padding = layout.minimumLineSpacing
        cellWidth = (UIScreen.main.bounds.width - (3 * padding))/2
        refCell.setWidthConstraint(cellWidth)
        getItems()
    }
    
    func getItems() {
        model.getData() { result in
            switch result {
            case .error(_):
                // TODO: show error
                break
            case let .success(data):
                self.items = data
                self.collectionView.reloadData()
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
        cell.data = items[indexPath.item]
        return cell
    }
}

extension GrailedListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let size = refCell.size(with: items[indexPath.item], for: cellWidth)
        
        print(size)
        
        return size
    }
    
}
 
