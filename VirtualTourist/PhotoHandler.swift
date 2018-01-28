//
//  PhotoHandler.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 1/28/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

protocol PhotoDelegate {
    func photoLoaded(photo: [UIImage])
}

class PhotoHandler: NSObject {

    static let shared = PhotoHandler()
    var photos : [UIImage]?
    var delegate : PhotoDelegate?
    
    override init() {
        super.init()
    }
    
    //MARK:- private methods
    
    //MARK:- public methods
    func refreshSetOfImages() {
        
    }
    
    func getPhotosByLocation(latitude lat: Double, longitude long: Double) {
        
    }
    
    
}
