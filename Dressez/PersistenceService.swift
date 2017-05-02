//
//  PersistenceService.swift
//  Dressez
//
//  Created by Dora Stipković on 4/28/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct PersistenceService {
    
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

extension PersistenceService {
    
    func createClothingItem(name: String,
                            image: UIImage,
                            type: ItemType,
                            color: ItemColor,
                            completion: @escaping (ClothingItem) -> ()) {
        guard let context = context else {
            fatalError("context not available")
        }
        
        ClothingItem.insert(into: context, name: name, image: image, type: type, color: color) {
            clothingItem in completion(clothingItem)
        }
    }
    
    func update(clothingItem: ClothingItem) {
        guard let context = clothingItem.managedObjectContext else {
            print("context not available")
            return
        }
        
        context.perform {
            let status = context.saveOrRollback()
            print("context saved:", status)
        }
    }
    
    func delete(clothingItem: ClothingItem) {
        guard let context = clothingItem.managedObjectContext else {
            print("context not available")
            return
        }
        
        context.perform {
            let imageService = ImageService()
            imageService.delete(fileName: clothingItem.imagePath)
            context.delete(clothingItem)
            let status = context.saveOrRollback()
            print("context saved:",  status)
        }
    }
    
    func fetchAllItems() -> NSFetchedResultsController<NSFetchRequestResult> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ClothingItem")
        request.sortDescriptors=[NSSortDescriptor(key: "typeId", ascending: false)]
        
        let resultController = fetchController(forRequest: request)
        try! resultController.performFetch()
        return resultController
    }
    
    func fetchClothingItems(with itemTypes: [Int]) -> [ClothingItem] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ClothingItem")
        let predicate = NSPredicate(format: "typeId IN %@", itemTypes)
        request.predicate = predicate
        
        do {
            return try context.fetch(request) as! [ClothingItem]
        } catch {
            fatalError("Failed to fetch clothing items: \(error)")
        }
    }
}
