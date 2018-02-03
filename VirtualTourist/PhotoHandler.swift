//
//  PhotoHandler.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 1/28/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class PhotoHandler: NSObject {
    
    var photos : [PhotoModel]?
    
    //MARK:- private methods
    
    //MARK:- public methods
    func refreshSetOfImages() {
        
    }
    
    func getPhotosByLocation(latitude lat: Double, longitude long: Double, locationName: String, completionBlock: Constants.CompletionBlock?) {
        FlickrHandler.shared.getPhotoByLocation(lat: lat, long: long,locationName: locationName, completionBlock: completionBlock)
    }
}
