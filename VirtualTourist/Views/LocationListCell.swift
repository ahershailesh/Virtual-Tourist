//
//  LocationListCell.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 2/4/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class LocationListCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countLabelView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var location: Location? {
        didSet {
            title.text = location?.locationName
            let lat = location!.lat
            let long = location!.long
            subTitle.text = "\(lat), \(long)"
            countLabel.text = String(location?.pictureResult?.pic?.count ?? 0)
            
            countLabelView.layer.cornerRadius = countLabel.frame.width/2
            selectionStyle = .none
        }
    }
    
}
