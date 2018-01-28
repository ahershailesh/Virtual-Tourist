//
//  PhotoHandler.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 1/28/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

protocol PhotoDelegate {
    func photoLoaded(photo: [Photo])
}

class PhotoHandler: NSObject {

    var photos : [Photo]?
    var delegate : PhotoDelegate?
    
    override init() {
        super.init()
    }
    
    //MARK:- private methods
    
    //MARK:- public methods
    func refreshSetOfImages() {
        
    }
    
    func getPhotosByLocation(latitude lat: Double, longitude long: Double) {
        FlickrHandler.shared.getPhotoByLocation(lat: lat, long: long)  { (success, response, error) in
            if let dict = response as? [String : Any] {
                if let diction = dict["photos"] as? [String: Any], let array = diction["photo"] as? [[String: Any]] {
                    let photos = array.map({ (dict) -> Photo in
                        let photo = Photo()
                        photo.map(dictionary: dict)
                        return photo
                    })
                    self.photos = photos
                    self.delegate?.photoLoaded(photo: photos)
                }
            }
        }
    }
}
