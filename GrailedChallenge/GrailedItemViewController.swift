//
//  GrailedItemViewController.swift
//  GrailedChallenge
//
//  Created by jay on 5/11/17.
//  Copyright © 2017 jay. All rights reserved.
//

import UIKit

class GrailedItemViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var designerLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var data: Item!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = data.designerName
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        ImageManager.shared.imageData(for: data.photo.url) { data in
            DispatchQueue.main.async {
                self.configure(imageData: data)
            }
        }
    }
    
    func configure(imageData: Data?) {
        self.spinner.stopAnimating()
        contentView.alpha = 0
        
        // Image
        var image = UIImage(named: "error")!
        var res: CGFloat = 1
        if let imageData = imageData,
            let i = UIImage(data: imageData) {
            image = i
            res = UIScreen.main.scale
        }
        let width = min(image.size.width/res, UIScreen.main.bounds.width)
        let height = width * image.size.height / image.size.width
        self.imageViewWidthConstraint.constant = width
        self.imageViewHeightConstraint.constant = height
        self.imageView.image = image
        // Labels
        titleLabel.text = data.title
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.generatesDecimalNumbers = false
        formatter.maximumFractionDigits = 0
        designerLabel.text = formatter.string(from: NSNumber(integerLiteral: data.price))
        descLabel.text = data.desc
        
        UIView.animate(withDuration: 0.5) {
            self.contentView.alpha = 1
        }
    }
}
