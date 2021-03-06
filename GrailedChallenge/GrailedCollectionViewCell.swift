//
//  GrailedCollectionViewCell.swift
//  GrailedChallenge
//
//  Created by jay on 5/10/17.
//  Copyright © 2017 jay. All rights reserved.
//

import UIKit

class GrailedCollectionViewCell: UICollectionViewCell {
    
    fileprivate static var width: CGFloat = 0
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var designerLabel: UILabel!
    
    private var imageClosure : ImageClosure?

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageClosure = nil
        imageView.contentMode = .scaleAspectFill
    }
    
    var data: Item! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        titleLabel.text = data.title
        designerLabel.text = data.designerName
        
        setImageViewHeight(with: data)
        imageClosure = ImageClosure(view: self)
        ImageManager.shared.imageData(
            for: data.photo.url,
            complete: imageClosure!.complete
        )
    }
    
    func setImageViewHeight(with item: Item) {
        let height = round(GrailedCollectionViewCell.width * CGFloat(item.photo.height / item.photo.width))
        imageViewHeightConstraint.constant = height
    }
    
    
    //MARK: ref cell only
    //this is for cell pre-sizing
    func setWidthConstraint(_ width: CGFloat) {
        GrailedCollectionViewCell.width = width
        container.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func size(with item: Item) -> CGSize {
        setImageViewHeight(with: item)
        titleLabel.text = item.title
        designerLabel.text = item.designerName
        return container.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
}

private class ImageClosure {
    
    weak var view: GrailedCollectionViewCell?
    lazy var complete: (Data?) -> () = { [weak self] data in
        if let data = data {
            let image = UIImage(data: data)
            // Think there may be a bug in the API, seems to switch width and height sometimes
            if self?.view != nil && (CGFloat(self?.view?.data.photo.width ?? 0) != image?.size.width || CGFloat(self?.view?.data.photo.height ?? 0) != image?.size.height) {
                self?.view?.imageView.contentMode = .scaleAspectFit
            }
            DispatchQueue.main.async {
                self?.view?.imageView.image = image
            }
        } else {
            // TODO: load placeholder
            print("LOAD FAILED")
        }
    }
    
    init(view: GrailedCollectionViewCell) {
        self.view = view
    }
}
