//
//  GrailedItemViewController.swift
//  GrailedChallenge
//
//  Created by jay on 5/11/17.
//  Copyright © 2017 jay. All rights reserved.
//

import UIKit

class GrailedItemViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var designerLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var data: Item!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        
        titleLabel.text = data.title
        designerLabel.text = data.designerName
        descLabel.text = data.desc
        
        ImageManager.shared.imageData(for: data.photo.url) { data in
            if let data = data,
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    let res = UIScreen.main.scale
                    let width = min(image.size.width/res, UIScreen.main.bounds.width)
                    let height = width * image.size.height / image.size.width
                    self.imageViewWidthConstraint.constant = width
                    self.imageViewHeightConstraint.constant = height
                    self.imageView.image = image
                }
            }
        }
        
        
    }
}
