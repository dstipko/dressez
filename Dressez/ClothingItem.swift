//
//  Clothing Item.swift
//  Dressez
//
//  Created by Ivan Anic on 29/04/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import CoreData

class ClothingItem : NSManagedObject{
    
    @NSManaged var name : String
    @NSManaged private var typeId : Int
    @NSManaged private var colorId : Int
    @NSManaged var imagePath : String
    
    var type: ItemType {
        get {
            return ItemType(rawValue: self.typeId)!
        }
        set {
            self.typeId = newValue.rawValue
        }
    }

    var color: ItemColor {
        get {
            return ItemColor(rawValue: self.colorId)!
        }
        set {
            self.colorId = newValue.rawValue
        }
    }
}
