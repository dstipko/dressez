//
//  Clothing Item.swift
//  Dressez
//
//  Created by Ivan Anic on 29/04/17.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ClothingItem : NSManagedObject{
    
    @NSManaged var name : String
    @NSManaged private var typeId : Int
    @NSManaged private var categoryId : Int
    @NSManaged private var colorId : Int
    @NSManaged var imagePath : String
    
    private let imageService = ImageService()
    
    private(set) var image: UIImage? {
        get {
            return imageService.load(fileName: imagePath)
        }
        
        set {
            guard let image = newValue, let fileName = imageService.save(image: image) else {
                return
            }
            self.imagePath = fileName
        }
    }
    
    var type: ItemType {
        get {
            return ItemType(rawValue: self.typeId)!
        }
        set {
            self.typeId = newValue.rawValue
            self.category = ItemType(rawValue: self.typeId)!.getCategory()
        }
    }
    
    var category: ItemCategory {
        get {
            return ItemCategory(rawValue: self.categoryId)!
        }
        set {
            self.categoryId = newValue.rawValue
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
    
    static func insert(into context: NSManagedObjectContext,
                       name: String,
                       image: UIImage,
                       type: ItemType,
                       color: ItemColor,
                       completion: @escaping (ClothingItem) -> () ) {
        context.perform {
            let clothingItem: ClothingItem = context.insertObject()
            clothingItem.name = name
            clothingItem.image = image
            clothingItem.type = type
            clothingItem.color = color
            
            let status = context.saveOrRollback()
            print("context saved:", status)
            completion(clothingItem)
        }
    }
}
