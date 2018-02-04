//
//  MapResult+CoreDataClass.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 2/4/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//
//

import Foundation
import CoreData

@objc(MapResult)
public class MapResult: NSManagedObject {
    convenience init(centerX: Float, centerY : Float, zoomLevel : Int64, context: NSManagedObjectContext) {
        if let entity = NSEntityDescription.entity(forEntityName: "MapResult", in: context) {
            self.init(entity: entity, insertInto: context)
            self.centerX = centerX
            self.centerY = centerY
            self.zoomLevel = zoomLevel
        } else {
            fatalError("Cannot able to instantiate MapResult")
        }
    }
}

