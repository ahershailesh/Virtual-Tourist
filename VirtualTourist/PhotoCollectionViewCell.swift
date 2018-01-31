//
//  PhotoCollectionViewCell.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 1/28/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var photo : Photo? {
        didSet {
            guard let _ = photo else { return }
            backgroundThread {
                if let url = URL(string: FlickrHandler.shared.getUrl(photo: self.photo!)) {
                    self.imageView.setImage(with: url, callBack: { [weak self] in
                        self?.progressIndicator.isHidden = true
                    })
                }
            }
            
            progressIndicator.startAnimating()
            titleLabel.text = photo?.title
            backgroundColor = UIColor.lightGray
            crossButton.backgroundColor = UIColor.lightGray
        }
    }
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        crossButton.layer.cornerRadius = crossButton.frame.width/2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        progressIndicator.isHidden = false
    }
}
