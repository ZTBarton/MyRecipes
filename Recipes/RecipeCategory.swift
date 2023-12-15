//
//  Item.swift
//  Recipes
//
//  Created by Zach Barton on 12/4/23.
//

import Foundation
import SwiftData

@Model
final class RecipeCategory {
    var dateAdded: Date
    var lastUsed: Date
    @Attribute(.unique) var title: String
    
    var recipes: [Recipe] = []
    
    init(dateAdded: Date, lastUsed: Date, title: String) {
        self.dateAdded = dateAdded
        self.lastUsed = lastUsed
        self.title = title
    }
}
