//
//  Extensions.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 1/28/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

extension NSObject {
    func map(dictionary: [String: Any]) {
        let keyArray = propertyNames()
        for key in keyArray {
            if let value = dictionary[key] as? String{
                setValue(value, forKey: key)
            }
        }
    }
    
    private func propertyNames() -> [String] {
        return Mirror(reflecting: self).children.flatMap { $0.label }
    }
}
