//
//  OutfitService.swift
//  Dressez
//
//  Created by Tvrtko Zadro on 01/05/2017.
//  Copyright © 2017 Dora Stipković. All rights reserved.
//

import Foundation

class OutfitService {
    
    var persistanceService: PersistanceService
    
    init() {
        persistanceService = PersistanceService()
    }
    
    func generateOutfitFor(weatherInfo: WeatherResponse) -> [ClothingItem] {
        let appropriateTemperatureItemTypes = getItemTypesFor(temperature: weatherInfo.tempCurrent!)
        let appropriateConditionItemTypes = getItemTypesFor(weatherCondition: weatherInfo.weatherCondition!)
        let itemTypes = appropriateTemperatureItemTypes.filter {
            if appropriateConditionItemTypes.contains($0) {
                return true
            } else {
                return false
            }
        }
        
        let weatherAppropriateItems = persistanceService.fetchClothingItems(itemTypes: itemTypes)
        
        var colorMatchingItems: [ClothingItem]
        var outfit: [ClothingItem]
        
        for colorPalette in ItemColor.complementarySets.shuffled() {
            outfit = [ClothingItem]()
            
            colorMatchingItems = weatherAppropriateItems.filter {
                if ItemColor.neutralValues.contains($0.color) || colorPalette.contains($0.color) {
                    return true
                } else {
                    return false
                }
            }
            
            colorMatchingItems.shuffle()
            
            for type in ItemType.allValues {
                if let distinctItem = (colorMatchingItems.filter { return $0.type == type }).first {
                    print(distinctItem.name)
                    outfit.append(distinctItem)
                }
            }
            
            if isValidOutfit(outfit: outfit) {
                //TODO: remove this block
                for (index, item) in outfit.enumerated() {
                    print(index)
                    print(item.name)
                    print(item.color.description())
                    print(item.type.description())
                    print(item.category.description())
                }
                //
                return outfit
            }
        }
        
        return []
    }
    
    private func isValidOutfit(outfit: [ClothingItem]) -> Bool {
        let outfitCategories = outfit.map { $0.category }
        
        for category in ItemCategory.crucialCategories {
            if !outfitCategories.contains(category) {
                return false
            }
        }
        
        return true
    }
    
    private func getItemTypesFor(temperature: Int) -> [Int] {
        var enumArray: [ItemType]
        
        switch temperature {
        case -100..<5:
            enumArray = [.trousers, .tracksuit, .shirt, .hoodie, .sweater, .heavyJacket, .coat, .leatherShoes, .boots]
        case 5..<15:
            enumArray = [.trousers, .tracksuit, .shirt, .hoodie, .sweater, .lightJacket, .heavyJacket, .coat, .canvasShoes, .leatherShoes, .boots]
        case 15..<25:
            enumArray = [.shorts, .trousers, .tracksuit, .shirt, .tshirt, .hoodie, .sweater, .lightJacket, .coat, .canvasShoes, .leatherShoes]
        case 25..<100:
            enumArray = [.shorts, .trousers, .tracksuit, .shirt, .tshirt, .hoodie, .sweater, .lightJacket, .canvasShoes, .leatherShoes]
        default:
            enumArray = []
        }
        
        return enumArray.map({
            (enumValue: ItemType) -> Int in
            return enumValue.rawValue
        })
    }
    
    private func getItemTypesFor(weatherCondition: WeatherCondition) -> [Int] {
        var enumArray: [ItemType]
        
        switch weatherCondition {
        case .storm:
            enumArray = [.trousers, .tracksuit, .shirt, .hoodie, .sweater, .heavyJacket, .coat, .leatherShoes, .boots]
        case .drizzle:
            enumArray = [.trousers, .tracksuit, .shirt, .tshirt, .hoodie, .sweater, .lightJacket, .coat, .leatherShoes, .boots]
        case .rain:
            enumArray = [.trousers, .tracksuit, .shirt, .hoodie, .sweater, .lightJacket, .heavyJacket, .coat, .leatherShoes, .boots]
        case .snow:
            enumArray = [.trousers, .tracksuit, .shirt, .hoodie, .sweater, .lightJacket, .heavyJacket, .coat, .leatherShoes, .boots]
        case .mist:
            enumArray = [.trousers, .tracksuit, .tshirt, .shirt, .hoodie, .sweater, .lightJacket, .coat, .leatherShoes, .boots]
        case .sun:
            enumArray = [.shorts, .trousers, .tracksuit, .shirt, .tshirt, .hoodie, .sweater, .lightJacket, .canvasShoes, .leatherShoes]
        case .cloud:
            enumArray = [.shorts, .trousers, .tracksuit, .shirt, .tshirt, .hoodie, .sweater, .lightJacket, .canvasShoes, .leatherShoes]
        }
        
        return enumArray.map({
            (enumValue: ItemType) -> Int in
            return enumValue.rawValue
        })
    }
}
