//
//  Location+CoreDataProperties.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 2/3/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var locationName: String?
    @NSManaged public var pictureResult: NSSet?

}

// MARK: Generated accessors for pictureResult
extension Location {

    @objc(addPictureResultObject:)
    @NSManaged public func addToPictureResult(_ value: PicturesResult)

    @objc(removePictureResultObject:)
    @NSManaged public func removeFromPictureResult(_ value: PicturesResult)

    @objc(addPictureResult:)
    @NSManaged public func addToPictureResult(_ values: NSSet)

    @objc(removePictureResult:)
    @NSManaged public func removeFromPictureResult(_ values: NSSet)

}
