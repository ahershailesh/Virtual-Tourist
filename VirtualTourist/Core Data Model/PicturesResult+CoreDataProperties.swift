//
//  PicturesResult+CoreDataProperties.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 2/3/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//
//

import Foundation
import CoreData


extension PicturesResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PicturesResult> {
        return NSFetchRequest<PicturesResult>(entityName: "PicturesResult")
    }

    @NSManaged public var page: String?
    @NSManaged public var pages: String?
    @NSManaged public var perpage: String?
    @NSManaged public var total: String?
    @NSManaged public var pic: NSSet?

}

// MARK: Generated accessors for pic
extension PicturesResult {

    @objc(addPicObject:)
    @NSManaged public func addToPic(_ value: Picture)

    @objc(removePicObject:)
    @NSManaged public func removeFromPic(_ value: Picture)

    @objc(addPic:)
    @NSManaged public func addToPic(_ values: NSSet)

    @objc(removePic:)
    @NSManaged public func removeFromPic(_ values: NSSet)

}
