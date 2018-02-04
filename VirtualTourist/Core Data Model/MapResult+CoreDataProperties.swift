//
//  MapResult+CoreDataProperties.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 2/4/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//
//

import Foundation
import CoreData


extension MapResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MapResult> {
        return NSFetchRequest<MapResult>(entityName: "MapResult")
    }

    @NSManaged public var centerX: Float
    @NSManaged public var centerY: Float
    @NSManaged public var zoomLevel: Int64

}
