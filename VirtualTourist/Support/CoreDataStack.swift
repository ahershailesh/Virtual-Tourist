//
//  CoreDataStack.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 1/28/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import CoreData

class CoreDataStack: NSObject {

    var dbUrl: URL?
    var modelURL: URL?
    var model : NSManagedObjectModel?
    var coordinator: NSPersistentStoreCoordinator?
    var context : NSManagedObjectContext?
    
    init(modelName: String) {
        super.init()
        //modelURL
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            saveLog("unable to fetch model url")
            return
        }
        self.modelURL = modelURL
        
        //model
        guard let model =  NSManagedObjectModel(contentsOf: modelURL) else {
            saveLog("unable to fetch model")
            return
        }
        
        self.model = model
        
        //coordinator
        self.coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        //context
        self.context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context?.persistentStoreCoordinator = coordinator
        
        //PersistentStore
        let fm = FileManager.default
        guard  let docUrl = fm.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            saveLog("unable to reach to the document folder")
            return
        }
        
        let dbUrl = docUrl.appendingPathExtension("model.sqlite")
        saveLog("db path : " + dbUrl.absoluteString)
        do {
            try coordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: dbUrl, options: nil)
        } catch {
            saveLog("unable to add store")
        }
        self.dbUrl = dbUrl
    }
    
    func save() {
        if context?.hasChanges ?? false {
            do {
                try context?.save()
            } catch let error {
                saveLog("unable to save context \(error)")
            }
        }
    }
}
