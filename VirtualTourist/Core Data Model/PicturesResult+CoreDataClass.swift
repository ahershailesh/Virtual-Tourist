//
//  PicturesResult+CoreDataClass.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 2/3/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//
//

import Foundation
import CoreData

@objc(PicturesResult)
public class PicturesResult: NSManagedObject {

    convenience init(dict: [AnyHashable: Any], contenxt: NSManagedObjectContext) {
        if let entityDescription = NSEntityDescription.entity(forEntityName: "PicturesResult", in: contenxt) {
            self.init(entity: entityDescription, insertInto: contenxt)
            self.page = String(describing: dict["page"]!)
            self.pages = String(describing: dict["pages"]!)
            self.perpage = String(describing: dict["perpage"]!)
            self.total = String(describing: dict["total"]!)
        } else {
            fatalError("cannot able to fetch PicturesResult")
        }
    }
}
