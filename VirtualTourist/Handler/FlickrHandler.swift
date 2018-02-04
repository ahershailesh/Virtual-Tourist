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
    
    func getPhotoByLocation(lat: Double, long : Double, locationName: String, completionBlock: Constants.CompletionBlock?) {
        let queryParam = ["lat" : String(lat), "lon" : String(long), "method" : "flickr.photos.search"]
        let savedLocation = getLocation(dict: ["lat" : lat, "long" : long, "locationName" : locationName])
        networkManager.get(queryParam: queryParam) { (success, response, error) in
            
            var result : PicturesResult?
            
            if success, let dict = response as? [String : Any] {
                if let diction = dict["photos"] as? [String: Any], let array = diction["photo"] as? [[String: Any]] {
                    let photos = array.map({ (dict) -> PhotoModel in
                        let photo = PhotoModel()
                        photo.map(dictionary: dict)
                        photo.farm = (dict["farm"] as?  NSNumber)?.stringValue
                        return photo
                    })
                    result = self.getPicturesResult(dict: diction)
                    savedLocation.pictureResult = result
                    if photos.isEmpty {
                        result = nil
                    } else {
                        photos.forEach({ (photo) in
                            let picture = self.getPict(photoModel: photo)
                            result?.addToPic(picture)
                        })
                    }
                }
            }
            completionBlock?(success, result, error)
        }
    }
    
    func getLocation(dict: [AnyHashable: Any]) -> Location {
        let lat = dict["lat"] as! Double
        let long = dict["long"] as! Double
        let locationName = dict["locationName"] as! String
        let location = Location(lat: lat, long: long, locationName: locationName, contenxt: appDelegate.coreDataStack.context!)
        
        saveLog(location)
        return location
    }
    
    func getPicturesResult(dict: [AnyHashable: Any]) -> PicturesResult {
        let thisDict = dict.filter { (key, value) -> Bool in
            if let keyString = key as? String, keyString != "photo" {
                return true
            }
            return false
        }
        let pictureResult = PicturesResult(dict: thisDict, contenxt: appDelegate.coreDataStack.context!)
        saveLog(pictureResult)
        return pictureResult
    }
    
    func getPict(photoModel: PhotoModel) -> Picture {
        let link = FlickrHandler.shared.getUrlString(photo: photoModel)
        let title = photoModel.title
        let model = Picture(link: link, title: title ?? "-" , contenxt: appDelegate.coreDataStack.context!)
        return model
    }
    
    func getUrlString(photo: PhotoModel) -> String {
        let imageName = photo.id! + "_" + photo.secret! + ".jpg"
        let url = "http://farm"+photo.farm!+".staticflickr.com/"+photo.server!+"/" + imageName
        return url
    }
    
    func getImage(fromUrl url : String, completionBlock: Constants.CompletionBlock?) {
        networkManager.getData(urlString: url, completionBlock: completionBlock)
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
