//
//  PhotoCollectionViewCell.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 1/28/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell, Placeholder {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var isChecked = false {
        didSet {
            crossButton.isHidden = !isChecked
            titleLabel.isHidden = isChecked
            var scale : CGFloat = 1
            if isChecked {
                scale = 0.8
            }
            UIView.animate(withDuration: 0.3) {
                self.imageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
    }
    
    var picture : Picture? {
        didSet {
            guard let picture = picture else { return }
            progressIndicator.startAnimating()
            titleLabel.text = picture.title
            
            guard let imageData = picture.pic  else {
                progressIndicator.isHidden = false
                if let link = picture.link, let url = URL(string: link) {
                    imageView.kf.setImage(with: url, placeholder: self, completionHandler: { (image, error, _, _) in
                        if let thisImage = image {
                            self.progressIndicator.isHidden = true
                            picture.pic = UIImagePNGRepresentation(thisImage) as NSData?
                        }
                    })
                }
                return
            }
            progressIndicator.isHidden = true
            imageView.image = UIImage(data: imageData as Data)
        }
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        crossButton.layer.cornerRadius = crossButton.frame.width/2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        progressIndicator.isHidden = true
        imageView.image = nil
        crossButton.isHidden = true
    }
    
    //MARK:- Placeholder Protocol -
    func add(to imageView: ImageView) {
        imageView.image = UIImage(named: "no_image")
    }
    
    func remove(from imageView: ImageView) {
        imageView.image = nil
    }
}
