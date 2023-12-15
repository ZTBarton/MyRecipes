//
//  Item.swift
//  Recipes
//
//  Created by Zach Barton on 12/4/23.
//

import Foundation
import SwiftData

@Model
final class Ingredient {
    var order: Int
    var amount: Float
    var unit: String
    var name: String
    
    init(order: Int, amount: Float, unit: String, name: String) {
        self.order = order
        self.amount = amount
        self.unit = unit
        self.name = name
    }
}
