//
//  Picture+CoreDataProperties.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 2/4/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//
//

import Foundation
import CoreData


extension Picture {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Picture> {
        return NSFetchRequest<Picture>(entityName: "Picture")
    }

    @NSManaged public var link: String?
    @NSManaged public var pic: NSData?
    @NSManaged public var title: String?

}
