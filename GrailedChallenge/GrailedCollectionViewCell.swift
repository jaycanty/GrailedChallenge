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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageAspectRatioConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var designerLabel: UILabel!
    
    private var imageClosure : ImageClosure?

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageClosure = nil
    }
    
    var data: Item! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        titleLabel.text = data.title
        designerLabel.text = data.designerName
        
        imageClosure = ImageClosure(view: self)
        ImageManager.shared.image(
            for: data.photo.url,
            complete: imageClosure!.complete
        )
    }
}

private class ImageClosure {
    
    weak var view: GrailedCollectionViewCell?
    lazy var complete: (Data?) -> () = { [weak self] data in
        if let data = data {
            let image = UIImage(data: data)
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

//MARK: ref cell - this is to get cell size
extension GrailedCollectionViewCell {
    
    func setWidthConstraint(_ width: CGFloat) {
        container.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func size(with item: Item) -> CGSize {
        titleLabel.text = item.title
        designerLabel.text = item.designerName
        return container.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
}


