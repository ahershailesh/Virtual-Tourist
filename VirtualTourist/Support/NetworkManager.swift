//
//  NetworkManager.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 1/28/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import Foundation

protocol NetworkProtocol {
    func getUrl() -> String
    func compulsoryPathParam() -> [String]
    func compulsoryQueryParam() -> [String : String]
    func compulsoryHeaders() -> [String : String]
}

class NetworkManager: NSObject {
    
    var delegate : NetworkProtocol?
    
    func get(pathParam: [String]? = nil, queryParam: [String: String]? = nil, headers: [String: String]? = nil, completionBlock: Constants.CompletionBlock?) {
        
        var url = delegate?.getUrl() ?? ""
        
        let compulsoryPathParam = delegate?.compulsoryPathParam() ?? []
        url = url + "/" + compulsoryPathParam.joined(separator: "/")
        url = url + "/" + (pathParam?.joined(separator: "/") ?? "")
        
        let compulsoryQueryParam = delegate?.compulsoryQueryParam() ?? [:]
        url = url + "?" + compulsoryQueryParam.map { (key, value) -> String in
            return key + "=" + value
            }.joined(separator: "&")
        
        url = url + "&" + (queryParam?.map { (key, value) -> String in
            return key + "=" + value
            }.joined(separator: "&") ?? "")
        saveLog(url)
        if let thisUrl = URL(string: url) {
            let request = URLRequest(url: thisUrl)
            let urlSession = URLSession.shared
            let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
                let success =  error == nil
                var json : [String: Any]?
                if success {
                    do {
                    json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                        saveLog(json)
                    } catch {
                        saveLog("got error url = " + url)
                    }
                } else {
                    saveLog(error)
                }
                completionBlock?(success, json, error)
            })
            task.resume()
        }
    }
    
    func getData(urlString: String, completionBlock: Constants.CompletionBlock?) {
        saveLog("Downloading image from url = "+urlString)
        if let url = URL(string: urlString) {
            backgroundThread {
                let data = NSData(contentsOf: url)
                completionBlock?(true, data, nil)
            }
        }
    }
    
}
