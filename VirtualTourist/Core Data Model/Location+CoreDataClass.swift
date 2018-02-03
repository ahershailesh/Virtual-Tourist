//
//  Location+CoreDataClass.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 2/3/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Location)
public class Location: NSManagedObject {
    convenience init(lat: Double, long: Double, locationName: String, contenxt: NSManagedObjectContext) {
        if let entityDescription = NSEntityDescription.entity(forEntityName: "Location", in: contenxt) {
            self.init(entity: entityDescription, insertInto: contenxt)
            self.locationName = locationName
            self.lat = lat
            self.long = long
        } else {
            fatalError("cannot able to fetch Location")
        }
    }
}
