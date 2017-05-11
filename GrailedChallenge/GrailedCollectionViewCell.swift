//
//  GrailedCollectionViewCell.swift
//  GrailedChallenge
//
//  Created by jay on 5/10/17.
//  Copyright © 2017 jay. All rights reserved.
//

import UIKit

class GrailedCollectionViewCell: UICollectionViewCell {
    
    static var width: CGFloat = 0

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var containerViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageAspectRatioConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var designerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    var data: Item! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        titleLabel.text = data.title
        designerLabel.text = data.designerName
    }
    
    func size(with item: Item, for width: CGFloat) -> CGSize {
        containerViewWidthConstraint.constant = width
        titleLabel.text = item.title
        designerLabel.text = item.designerName
        return container.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }

    
}
