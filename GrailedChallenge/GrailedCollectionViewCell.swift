//
//  GrailedCollectionViewCell.swift
//  GrailedChallenge
//
//  Created by jay on 5/10/17.
//  Copyright © 2017 jay. All rights reserved.
//

import UIKit

class GrailedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageAspectRatioConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var designerLabel: UILabel!
    
    var data: Item! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        titleLabel.text = data.title
        designerLabel.text = data.designerName
    }
    
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let atrbs = super.preferredLayoutAttributesFitting(layoutAttributes)
        print(atrbs.frame)
        return atrbs
    }
}
