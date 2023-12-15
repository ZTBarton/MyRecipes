//
//  RecipeContentView.swift
//  Recipes
//
//  Created by Zach Barton on 12/12/23.
//

import SwiftUI
import SwiftData

struct RecipeContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var recipe: Recipe

    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            Text(recipe.title)
                .font(.system(size: 50, weight: .bold))
            Text("By: \(recipe.author)")
                .font(.title2)
            Text(recipe.recipeDescription ?? "No description")
                .font(.body)
                .italic(recipe.recipeDescription == nil)
            HStack {
                VStack (alignment: .leading, spacing: 20) {
                    Text("Servings: \(recipe.servings.map(String.init) ?? "Unknown")")
                    Text("Time Required: \(recipe.timeRequired.map(String.init) ?? "Unknown")")
                    Text("Difficulty Level: \(recipe.difficultyLevel.map(String.init) ?? "Unknown")")
                    Text("Calories per Serving: \(recipe.calories.map(String.init) ?? "Unknown")")
                }
                .padding()
                .background(.selection)
                .cornerRadius(10)
            .padding()
            }
            
            Text("Ingredients:")
                .font(.title2)
                .bold()
                .padding(.top, 30)
            VStack (alignment: .leading, spacing: 5) {
                ForEach(recipe.ingredients.sorted(by: { $0.order < $1.order })) { ing in
                    Text("• \(floor(ing.amount) > 0 ? forTrailingZero(floor(ing.amount)) : "") \(findClosestKey(for: ing.amount.truncatingRemainder(dividingBy: 1))) \(ing.unit)\(ing.amount > 1 ? "s" : "") \(ing.name)")
                }
            }
            .padding(.leading)
            
            Text("Instructions:")
                .font(.title2)
                .bold()
                .padding(.top, 30)
            VStack (alignment: .leading, spacing: 0) {
                ForEach(recipe.instructions.sorted(by: { $0.stepNum < $1.stepNum })) { step in
                    Text(step.title).bold()
                    Text(step.instruction)
                        .padding(.leading)
                        .padding(.vertical)
                }
            
            }.if(horizontalSizeClass == .regular) { view in
                view.padding()
            }
            
        }
    }
    
//  Credit for the trailing zero function:  https://stackoverflow.com/questions/29560743/swift-remove-trailing-zeros-from-double
    private func forTrailingZero(_ temp: Float) -> String {
        return String(format: "%g", temp)
    }
}

//This was from chatGPT:
extension View {
    @ViewBuilder func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
//
//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: Recipe.self, configurations: config)
//
//    let recipe = Recipe(
//        dateAdded: Date(),
//        lastView: Date(),
//        title: "Buttermilk Pancakes",
//        author: "Zachary Barton",
//        recipeDescription: "Yummy buttermilk pancakes.",
//        categories: [],
//        ingredients: [
//            Ingredient(order: 1, amount: 2.0, unit: "Cup", name: "Flour"),
//            Ingredient(order: 2, amount: 1.0, unit: "tsp", name: "Salt"),
//            Ingredient(order: 3, amount: 1.0, unit: "Cup", name: "Milk")
//        ], instructions: [
//            Step(stepNum: 1, title: "Step 1", instruction: "Put the flour and salt in a bowl."),
//            Step(stepNum: 2, title: "Step 2", instruction: "Add milk to the bowl and beat with a whisk.")
//        ],
//        timeRequired: 30,
//        servings: 8,
//        difficultyLevel: 3,
//        calories: 450,
//        notes: ["It's best to use real buttermilk."],
//        tags: ["sweet"]
//    )
//    return RecipeContentView(recipe: recipe)
//        .modelContainer(container)
//}

//#Preview {
//    RecipeContentView(recipe: Recipe(dateAdded: Date(), lastView: Date(), title: "Buttermilk Pancakes", author: "Zachary Barton", recipeDescription: "Yummy buttermilk pancakes.", categories: [], ingredients: [
//        Ingredient(order: 1, amount: 2.0, unit: "Cup", name: "Flour"),
//        Ingredient(order: 2, amount: 1.0, unit: "tsp", name: "Salt"),
//        Ingredient(order: 3, amount: 1.0, unit: "Cup", name: "Milk")
//    ], instructions: [
//        Step(stepNum: 1, title: "Step 1", instruction: "Put the flour and salt in a bowl."),
//        Step(stepNum: 2, title: "Step 2", instruction: "Add milk to the bowl and beat with a whisk.")
//    ], timeRequired: 30, servings: 8, difficultyLevel: 3, calories: 450, notes: ["It's best to use real buttermilk."], tags: ["sweet"])
//    )
//    .modelContainer(for: Recipe.self, inMemory: true)
//}
