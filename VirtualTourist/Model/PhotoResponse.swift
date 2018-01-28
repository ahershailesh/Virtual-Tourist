//
//  PhotoResponse.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 1/28/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

class PhotoResponse: NSObject {
    @objc var page : String?
    @objc var pages : String?
    @objc var perpage : String?
    @objc var total : String?
    @objc var stat : String?
    @objc var photo : [Photo]?
}
