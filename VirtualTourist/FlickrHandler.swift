//
//  FlickrHandler.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 1/28/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class FlickrHandler: NSObject {

    static let shared = FlickrHandler()
    private let networkManager = NetworkManager()
    
    override init() {
        super.init()
        networkManager.delegate = self
    }
    
    func getPhotoByLocation(lat: Double, long : Double, completionBlock: Constants.CompletionBlock?) {
        let queryParam = ["lat" : String(lat), "lon" : String(long), "method" : "flickr.photos.search"]
        networkManager.get(queryParam: queryParam, completionBlock: completionBlock)
    }
    
}

extension FlickrHandler : NetworkProtocol {
    
    func getUrl() -> String {
        return Constants.Url
    }
    
    func compulsoryPathParam() -> [String] {
        return ["services", "rest"]
    }
    
    func compulsoryQueryParam() -> [String : String] {
        return ["api_key" : Constants.FlickrKey,
                "format" : "json",
                "nojsoncallback" : "1"]
    }
    
    func compulsoryHeaders() -> [String : String] {
        return [:]
    }
}
