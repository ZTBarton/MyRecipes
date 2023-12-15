//
//  NavigationContext.swift
//  Recipes
//
//  Created by Zach Barton on 12/11/23.
//

import SwiftUI

@Observable
class NavigationContext {
    var selectedRecipeCategories: [RecipeCategory]
    var selectedRecipe: Recipe?
    var columnVisibility: NavigationSplitViewVisibility
    
    var sidebarTitle = "Categories"
    
    var contentListTitle = "Recipes"
    
    init(selectedRecipeCategories: [RecipeCategory],
         selectedRecipe: Recipe? = nil,
         columnVisibility: NavigationSplitViewVisibility = .automatic) {
        self.selectedRecipeCategories = selectedRecipeCategories
        self.selectedRecipe = selectedRecipe
        self.columnVisibility = columnVisibility
    }
}
