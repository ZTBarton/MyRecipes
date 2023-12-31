//
//  RecipesApp.swift
//  Recipes
//
//  Created by Zach Barton on 12/4/23.
//

import SwiftUI
import SwiftData

@main
struct RecipesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            RecipeCategory.self,
            Recipe.self,
            Ingredient.self,
            Step.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
