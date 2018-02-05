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
    
    var photo : PhotoModel? {
        didSet {
            guard let photo = photo else { return }
            progressIndicator.startAnimating()
            titleLabel.text = photo.title
        }
    }
    
    var picture : Picture? {
        didSet {
            guard let picture = picture else { return }
            progressIndicator.startAnimating()
            progressIndicator.isHidden = false
            titleLabel.text = picture.title
            
            guard let imageData = picture.pic  else {
                if let link = picture.link {
                    FlickrHandler.shared.getImage(fromUrl: link, completionBlock: { [weak self] (success, response, error) in
                        if success , let data = response as? Data {
                            picture.pic = data as NSData
                            mainThread {
                                self?.imageView.image = UIImage(data: data)
                                self?.progressIndicator.isHidden = true
                            }
                        } else {
                            saveLog("Caanot able to save pic for link = \(picture.link!)")
                        }
                    })
                }
                return
            }
            imageView.image = UIImage(data: imageData as Data)
            progressIndicator.isHidden = true
        }
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 4
        crossButton.layer.cornerRadius = crossButton.frame.width/2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        progressIndicator.isHidden = false
        imageView.image = nil
        crossButton.isHidden = true
    }
}
