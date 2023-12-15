//
//  Constants.swift
//  Recipes
//
//  Created by Zach Barton on 12/7/23.
//

struct Constants {
    static let IngredientUnits = [
        "cup",
        "fl oz",
        "tsp",
        "Tbsp",
        "gal",
        "pt",
        "qt",
        "ml",
        "L",
        "g",
        "kg",
        "oz",
        "lb",
        "pinch",
        "dash",
        "stick",
        "count",
        "to taste",
        "slice",
        "can"
    ]
    
    static let IngredientAmounts = [
        "" : 0.0,
        "1/8" : 0.125,
        "1/5" : 0.2,
        "1/4" : 0.25,
        "1/3" : 0.333333333,
        "3/8" : 0.375,
        "2/5" : 0.4,
        "1/2" : 0.5,
        "3/5" : 0.6,
        "5/8" : 0.625,
        "2/3" : 0.666666666,
        "3/4" : 0.75,
        "4/5" : 0.8,
        "7/8" : 0.875
    ]
}

//-- HELPERS

func findClosestKey(for decimalValue: Float) -> String {
    var closestKey: String = ""
    var smallestDifference = Float.greatestFiniteMagnitude

    for (key, value) in Constants.IngredientAmounts {
        let difference = abs(Float(value) - decimalValue)
        if difference < smallestDifference {
            smallestDifference = difference
            closestKey = key
        }
    }
    return closestKey
}
