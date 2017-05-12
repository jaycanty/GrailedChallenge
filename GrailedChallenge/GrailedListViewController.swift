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
    private let refresher = UIRefreshControl()
    
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
            if self.refresher.isRefreshing {
                self.refresher.endRefreshing()
            }
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.isFetching = false
            }
        }
    }
    
    fileprivate func configure() {
        // Cell stuff
        let nib = UINib(nibName: cellId, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellId)
        refCell = Bundle.main.loadNibNamed(cellId, owner: self, options: nil)!.first as! GrailedCollectionViewCell
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let padding = layout.minimumLineSpacing
        let cellWidth = (UIScreen.main.bounds.width - (3 * padding))/2
        refCell.setWidthConstraint(cellWidth)
        // Refresh stuff
        refresher.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        collectionView.addSubview(refresher)
    }
    
    func refresh(_ sender: UIRefreshControl) {
        model.reset()
        getItems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let details = segue.destination as? GrailedItemViewController,
            let item = sender as? GrailedChallenge.Item {
            details.data = item
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        performSegue(withIdentifier: "ToDetail", sender: item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Triggers one screen above content size
        if (scrollView.contentOffset.y + 2 * scrollView.bounds.height) >= scrollView.contentSize.height && !isFetching {
            getItems()
        }
    }
}
 
