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
    
    fileprivate let model = DataModel()
    fileprivate var items = [Item]()
    fileprivate var isFetching = false
    
    fileprivate let cellId = "GrailedCollectionViewCell"
    fileprivate var refCell: GrailedCollectionViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getItems()
    }
    
    fileprivate func getItems() {
        isFetching = true
        model.getData() { result in
            switch result {
            case .error(_):
                // TODO: show error
                break
            case let .success(data):
                let currentCount = self.items.count
                let newCount = data.count
                self.items = data
                if newCount > currentCount {
                    var paths = [IndexPath]()
                    for i in currentCount..<newCount {
                        paths.append(IndexPath(item: i, section: 0))
                    }
                    self.collectionView.insertItems(at: paths)
                } else {
                    self.collectionView.reloadData()
                }
            }
            self.isFetching = false
        }
    }
    
    fileprivate func configure() {
        let nib = UINib(nibName: cellId, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellId)
        refCell = Bundle.main.loadNibNamed(cellId, owner: self, options: nil)!.first as! GrailedCollectionViewCell
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let padding = layout.minimumLineSpacing
        let cellWidth = (UIScreen.main.bounds.width - (3 * padding))/2
        refCell.setWidthConstraint(cellWidth)
    }
}


extension GrailedListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GrailedCollectionViewCell
        cell.data = items[indexPath.item]
        return cell
    }
}

extension GrailedListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = refCell.size(with: items[indexPath.item])
        return size
    }
}

extension GrailedListViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Triggers one screen above content size
        if (scrollView.contentOffset.y + 2 * scrollView.bounds.height) >= scrollView.contentSize.height && !isFetching {
            getItems()
        }
    }
}
 
