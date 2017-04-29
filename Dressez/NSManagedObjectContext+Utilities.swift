//
//  NSManagedObjectContext+Utilities.swift
//  Dressez
//
//  Created by Tvrtko Zadro on 29/04/2017.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func insertObject<A: NSManagedObject>() -> A {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: A.entity().name!, into: self) as? A else { fatalError("Wrong object type") }
        return obj
    }
    
    func saveOrRollback() -> Bool {
        do {
            try save()
            return true
        } catch(let error) {
            print(error)
            rollback()
            return false
        }
    }
}
