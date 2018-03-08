//
//  Location+CoreDataClass.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 2/4/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//
//

import Foundation
import CoreData
import MapKit

@objc(Location)
public class Location: NSManagedObject {
    convenience init(lat: Double, long: Double, locationName: String, contenxt: NSManagedObjectContext) {
        if let entityDescription = NSEntityDescription.entity(forEntityName: "Location", in: contenxt) {
            self.init(entity: entityDescription, insertInto: contenxt)
            self.locationName = locationName
            self.lat = lat
            self.long = long
            self.createdDate = NSDate()
        } else {
            fatalError("cannot able to fetch Location")
        }
    }
    
    func getAnnotation() -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        if let latitude = CLLocationDegrees(exactly: lat),
            let longitude = CLLocationDegrees(exactly: long) {
         annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        annotation.subtitle = locationName
        return annotation
    }
}
