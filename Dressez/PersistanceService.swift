//
//  PersistanceService.swift
//  Dressez
//
//  Created by Dora Stipković on 4/28/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import CoreData

struct PersistanceService {
    private var storeURL: URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        return URL(fileURLWithPath: paths).appendingPathComponent("Dressez.sqlite")
    }
    
    private var managedModel: NSManagedObjectModel!
    private var persistanceCoordinator: NSPersistentStoreCoordinator!
    fileprivate var context: NSManagedObjectContext!
    
    init() {
        guard let model = NSManagedObjectModel.mergedModel(from: Bundle.allBundles) else {
            fatalError("model not found")
        }
        
        managedModel = model
        
        let mOptions = [NSMigratePersistentStoresAutomaticallyOption:true,
                        NSInferMappingModelAutomaticallyOption: true]
        
        persistanceCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        do {
            try persistanceCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: mOptions)
        }catch(_) {
            fatalError("failed to add persistant store")
        }
        
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistanceCoordinator
        
        print("storeURL:", storeURL.absoluteString)
        
        
    }
    
    func fetchController<T: NSFetchRequestResult>(forRequest request: NSFetchRequest<T>) -> NSFetchedResultsController<T> {
        guard let context = context else {
            fatalError("coludn't get managed context")
        }
        
        return NSFetchedResultsController(fetchRequest: request,
                                          managedObjectContext: context,
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)
    }

}
