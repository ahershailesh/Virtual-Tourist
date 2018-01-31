//
//  Constants.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 1/28/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    static let FlickrKey = "514a7e6e18b0b4d9ce2b42e211d9dbb6"
    static let FlickrSecret = "350868e251fca8b6"
    static let Url = "https://api.flickr.com"
    
    typealias CompletionBlock = ((Bool,Any?,Error?) -> Void)
    typealias VoidBlock = (() -> Void)
    
}

let appDelegate = UIApplication.shared.delegate as! AppDelegate

func saveLog(_ content : Any) {
    print(content)
}

func mainThread(block : Constants.VoidBlock?) {
    if Thread.isMainThread {
        block?()
    } else {
        DispatchQueue.main.sync {
            block?()
        }
    }
}

func backgroundThread(block : Constants.VoidBlock?) {
    DispatchQueue.main.async {
        block?()
    }
}
