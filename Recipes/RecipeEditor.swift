//
//  RecipeEditor.swift
//  Recipes
//
//  Created by Zach Barton on 12/11/23.
//

import SwiftUI
import SwiftData
import Combine

struct RecipeEditor: View {
    let recipe: Recipe?
    
    private var editorTitle: String {
        recipe == nil ? "Add Recipe" : "Edit Recipe"
    }
    
    @State var title: String = ""
    @State var author: String = ""
    @State var recipeDescription: String = ""
    @State var timeRequired: String = ""
    @State var selectedCategories: [RecipeCategory] = []
    @State var servings: String = ""
    @State var difficultyLevel: Int?
    @State var calories: String = ""
    @State var ingredients: [TemporaryIngredient] = []
    @State var instructions: [TemporaryStep] = []
    @State var notes: [String] = []
    @State var tags: [String] = []
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \RecipeCategory.title) private var categories: [RecipeCategory]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Recipe Details")) {
                    TextField("Title", text: $title)
                    
                    TextField("Author", text: $author)
                    
                    TextField("Description", text: $recipeDescription, axis: .vertical)
                    
                    MultiSelector(
                        label: Text("Categories"),
                        options: categories,
                        optionToString: { $0.title },
                        selected: $selectedCategories
                    )
                    
                    // See https://stackoverflow.com/questions/58733003/how-to-create-textfield-that-only-accepts-numbers
                    TextField("Time Required (Minutes)", text: $timeRequired)
                        .keyboardType(.numberPad) // Display a number pad keyboard
                        .onReceive(Just(timeRequired)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.timeRequired = filtered
                            }
                        }
                    
                    TextField("Servings", text: $servings)
                        .keyboardType(.numberPad) // Display a number pad keyboard
                        .onReceive(Just(servings)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.servings = filtered
                            }
                        }
                    
                    TextField("Calories per Serving", text: $calories)
                        .keyboardType(.numberPad) // Display a number pad keyboard
                        .onReceive(Just(calories)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.calories = filtered
                            }
                        }
                    
                    Picker("Difficulty Level", selection: $difficultyLevel) {
                        Text("").tag(nil as Int?)
                        ForEach(1...10, id: \.self) { level in
                            Text(String(level)).tag(level)
                        }
                    }
                    
                }
                
                Section(header: Text("Ingredients")) {
                    ForEach($ingredients.indices, id: \.self) { index in
                        HStack {
                            Picker(selection: $ingredients[index].amountWhole, label: Text("Amount")) {
                                ForEach(0...25, id: \.self) { num in
                                    Text(String(num)).tag(num)
                                }
                            }
                            
                            Picker(selection: $ingredients[index].amountFraction, label: EmptyView()) {
                                Text("0").tag("")
                                ForEach(sortedFractionsArray, id: \.self) { amountKey in
                                    Text(String(amountKey)).tag(String(amountKey))
                                }
                            }
                            
                            Picker(selection: $ingredients[index].unit, label: Text("Unit")) {
                                ForEach(Constants.IngredientUnits, id: \.self) { unit in
                                    Text(unit).tag(unit)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            
                            TextField("Name", text: $ingredients[index].name)
                        }
                    }
                    .onDelete(perform: deleteIngredient)
                    
                    Button(action: addIngredient) {
                        Text("Add Ingredient")
                    }
                }
                
                Section(header: Text("Instructions")) {
                    ForEach($instructions.indices, id: \.self) { index in
                        VStack {
                            TextField("Title", text: $instructions[index].title).fontWeight(.bold)
                            TextField("Instructions for this step...", text: $instructions[index].instruction, axis: .vertical)
                        }
                        .padding(.vertical, 8)
                    }
                    .onDelete(perform: deleteStep)
                    
                    Button(action: addStep) {
                        Text("Add Step")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    // Require a category to save changes.
                    .disabled($title.wrappedValue.isEmpty || $author.wrappedValue.isEmpty || $selectedCategories.wrappedValue.count == 0)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let recipe {
                    // Edit the incoming recipe.
                    title = recipe.title
                    author = recipe.author
                    recipeDescription = recipe.recipeDescription ?? ""
                    if let time = recipe.timeRequired {
                        timeRequired = String(time)
                    }
                    for cat in recipe.categories {
                        selectedCategories.append(cat)
                    }
                    if let serv = recipe.servings {
                        servings = String(serv)
                    }
                    difficultyLevel = recipe.difficultyLevel
                    if let cals = recipe.calories {
                        calories = String(cals)
                    }
                    ingredients = recipe.ingredients.map { TemporaryIngredient(ingredient: $0)}
                    instructions = recipe.instructions.map { TemporaryStep(step: $0)}
                    notes = recipe.notes
                    tags = recipe.tags
                    print(recipe.categories.map { $0.title}.joined(separator: ", "))
                }
            }
#if os(macOS)
            .padding()
#endif
        }
    }
    
    private var sortedFractionsArray: [String] {
        Array(Constants.IngredientAmounts.keys)
            .sorted { Constants.IngredientAmounts[$0] ?? 0 < Constants.IngredientAmounts[$1] ?? 0.0 }
    }
    
    private func addIngredient() {
        print(ingredients)
        ingredients.append(TemporaryIngredient(order: ingredients.count + 1, amount: 0, unit: "cup", name: ""))
    }
    
    private func deleteIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
    
    private func addStep() {
        instructions.append(TemporaryStep(id: String(instructions.count), stepNum: instructions.count + 1, title: "Step \(instructions.count + 1)", instruction: ""))
    }
    
    private func deleteStep(at offsets: IndexSet) {
        instructions.remove(atOffsets: offsets)
    }
    
    private func save() {
        if let recipe {
            print(recipe.categories.map { $0.title}.joined(separator: ", "))
            // Edit the recipe.
            recipe.title = title
            recipe.author = author
            recipe.recipeDescription = recipeDescription
            recipe.timeRequired = Int(timeRequired)
            recipe.categories = selectedCategories
            recipe.servings = Int(servings)
            recipe.difficultyLevel = difficultyLevel
            recipe.calories = Int(calories)
            recipe.notes = recipe.notes
            recipe.tags = recipe.tags
            
            for ing in recipe.ingredients {
                modelContext.delete(ing)
            }
            
            for step in recipe.instructions {
                modelContext.delete(step)
            }
            
            try? modelContext.save()
            var order = 1
            for ing in ingredients {
                recipe.ingredients.append(Ingredient(order: order, amount: Float(ing.amountWhole) + Float(Constants.IngredientAmounts[ing.amountFraction] ?? 0.0), unit: ing.unit, name: ing.name))
                order += 1
            }
            
            for step in instructions {
                recipe.instructions.append(Step(stepNum: step.stepNum, title: step.title, instruction: step.instruction))
            }
            try? modelContext.save()
            
        } else {
            // Add a recipe.
            print(selectedCategories.map { $0.title}.joined(separator: ", "))
            let newRecipe = Recipe(
                dateAdded: Date(),
                lastView: Date(),
                title: title,
                author: author,
                recipeDescription: !recipeDescription.isEmpty ? recipeDescription : nil as String? ,
                categories: [],
                ingredients: [],
                instructions: [],
                timeRequired: Int(timeRequired),
                servings: Int(servings),
                difficultyLevel: difficultyLevel,
                calories: Int(calories),
                notes: notes,
                tags: tags
            )
            modelContext.insert(newRecipe)
            
            for cat in selectedCategories {
                newRecipe.categories.append(cat)
            }
            
            for ing in ingredients {
                newRecipe.ingredients.append(Ingredient(order: ing.order, amount: Float(ing.amountWhole) + Float(Constants.IngredientAmounts[ing.amountFraction] ?? 0.0), unit: ing.unit, name: ing.name))
            }
            
            for step in instructions {
                newRecipe.instructions.append(Step(stepNum: step.stepNum, title: step.title, instruction: step.instruction))
            }
            try? modelContext.save()
        }
    }
    
//    static func findClosestKey(for decimalValue: Float) -> String {
//        var closestKey: String = ""
//        var smallestDifference = Float.greatestFiniteMagnitude
//
//        for (key, value) in Constants.IngredientAmounts {
//            let difference = abs(Float(value) - decimalValue)
//            if difference < smallestDifference {
//                smallestDifference = difference
//                closestKey = key
//            }
//        }
//        return closestKey
//    }
    
    struct TemporaryIngredient: Identifiable {
        var id: Int {
            order
        }
        var order: Int
        var amountWhole: Int
        var amountFraction: String
        var unit: String
        var name: String
        
        init(ingredient: Ingredient) {
            self.order = ingredient.order
            self.amountWhole = Int(floor(ingredient.amount))
            self.amountFraction = findClosestKey(for: ingredient.amount.truncatingRemainder(dividingBy: 1))
            self.unit = ingredient.unit
            self.name = ingredient.name
        }
        
        init(order: Int, amount: Float, unit: String, name: String) {
            self.order = order
            self.amountWhole = Int(floor(amount))
            self.amountFraction = findClosestKey(for: amount.truncatingRemainder(dividingBy: 1))
            self.unit = unit
            self.name = name
        }
    }
    
    struct TemporaryStep: Identifiable {
        var id: Int {
            stepNum
        }
        var stepNum: Int
        var title: String
        var instruction: String
        
        init(step: Step) {
            self.stepNum = step.stepNum
            self.title = step.title
            self.instruction = step.instruction
        }
        
        init(id: String, stepNum: Int, title: String, instruction: String) {
            self.stepNum = stepNum
            self.title = title
            self.instruction = instruction
        }
    }
}

#Preview("Add recipe") {
    RecipeEditor(recipe: nil)
        .modelContainer(for: Recipe.self, inMemory: true)
}
