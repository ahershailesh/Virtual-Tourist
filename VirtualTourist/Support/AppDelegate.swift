//
//  AppDelegate.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 1/28/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let coreDataStack = CoreDataStack(modelName: "Tourist")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        coreDataStack.autoSave(withDetay: 10)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        coreDataStack.save()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        coreDataStack.save()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.save()
    }
}

