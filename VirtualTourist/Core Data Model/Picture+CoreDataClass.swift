//
//  Picture+CoreDataClass.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 2/4/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Picture)
public class Picture: NSManagedObject {
    convenience init(link: String, title: String, contenxt: NSManagedObjectContext) {
        if let entityDescription = NSEntityDescription.entity(forEntityName: "Picture", in: contenxt) {
            self.init(entity: entityDescription, insertInto: contenxt)
            self.link = link
            self.title = title
        } else {
            fatalError("cannot able to fetch Picture")
        }
    }
}
