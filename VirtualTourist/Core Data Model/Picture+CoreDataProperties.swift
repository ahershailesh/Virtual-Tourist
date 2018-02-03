//
//  Picture+CoreDataProperties.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 2/3/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//
//

import Foundation
import CoreData


extension Picture {

    @NSManaged public var pic: NSData?
    @NSManaged public var link: String?

}
