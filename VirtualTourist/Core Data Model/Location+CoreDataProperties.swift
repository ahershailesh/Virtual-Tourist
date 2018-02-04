//
//  Location+CoreDataProperties.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 2/4/18.
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
    @NSManaged public var locationName: String?
    @NSManaged public var long: Double
    @NSManaged public var createdDate: NSDate?
    @NSManaged public var pictureResult: PicturesResult?

}
