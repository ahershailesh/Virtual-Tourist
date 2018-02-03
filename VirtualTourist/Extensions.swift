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

extension UIImageView {
    func setImage(with url : URL, callBack: Constants.VoidBlock? = nil) {
        backgroundThread {
            if let data = try? Data(contentsOf: url) {
                mainThread(block: {
                    self.image = UIImage(data: data)
                    callBack?()
                })
            }
        }
    }
}

extension UIViewController {
    
    func showAlert(message: String) {
        let controller = UIAlertController(title: "Important", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { (_) in
            controller.dismiss(animated: true, completion: nil)
        }
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
}
