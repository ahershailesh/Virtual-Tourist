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
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            print("unable to fetch model url")
            return
        }
        self.modelURL = modelURL
        
        guard let model =  NSManagedObjectModel(contentsOf: modelURL) else {
            print("unable to fetch model")
            return
        }
        self.model = model
        self.coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        self.context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context?.persistentStoreCoordinator = coordinator
        
        let fm = FileManager.default
        guard  let docUrl = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("unable to reach to the document folder")
            return
        }
        
        let dbUrl = docUrl.appendingPathExtension("model.sqlite")
        print("db path : " + dbUrl.absoluteString)
        do {
            try coordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: dbUrl, options: nil)
        } catch {
            print("unable to add store")
        }
        self.dbUrl = dbUrl
    }
    
    func save() {
        if context?.hasChanges ?? false {
            do {
                try context?.save()
            } catch {
                print("unable to save context")
            }
        }
    }
    
    func autoSave(withDetay delay: Int) {
        
        save()
        let delayTimeInNanoSeconds = UInt64(delay) * NSEC_PER_SEC
        let time = DispatchTime.now() +   Double(UInt64(delayTimeInNanoSeconds)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.autoSave(withDetay: delay)
        }
    }
    
}
