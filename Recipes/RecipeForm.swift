////
////  ContentView.swift
////  Recipes
////
////  Created by Zach Barton on 12/4/23.
////
//
//import SwiftUI
//import SwiftData
//import MarkdownUI
//import Combine
//
////struct RecipeForm: View {
////    @Environment(\.modelContext) private var modelContext
////    @Query private var categories: [RecipeCategory]
////    var recipe: Recipe?
////    
////    @State private var title: String = ""
////    @State private var author: String = ""
////    @State private var recipeDescription: String = ""
////    @State private var timeRequired: String = ""
////    @State private var selectedCategories: [RecipeCategory]
////    @State private var servings: String = ""
////    @State private var difficultyLevel: Int?
////    @State private var calories: String = ""
////    @State private var ingredients: [TemporaryIngredient] = []
////    @State private var instructions: [TemporaryStep] = []
////    @State private var notes: [String] = []
////    @State private var tags: [String] = []
////    
////    init(recipe: Recipe?) {
////        self.recipe = recipe
////        
////        if let recipe = recipe {
////            // Populate the state variables with existing recipe data
////            _title = State(initialValue: recipe.title)
////            _author = State(initialValue: recipe.author)
////            _recipeDescription = State(initialValue: recipe.recipeDescription ?? "")
////            _timeRequired = State(initialValue: recipe.timeRequired.map { String($0) } ?? "")
////            _selectedCategories = State(initialValue: recipe.categories)
////            _servings = State(initialValue: recipe.servings.map { String($0) } ?? "")
////            _difficultyLevel = State(initialValue: recipe.difficultyLevel)
////            _calories = State(initialValue: recipe.calories.map { String($0) } ?? "")
////            // Convert recipe ingredients and instructions to TemporaryIngredient and TemporaryStep
////            _ingredients = State(initialValue: recipe.ingredients.map { TemporaryIngredient(ingredient: $0) })
////            _instructions = State(initialValue: recipe.instructions.map { TemporaryStep(step: $0) })
////            _notes = State(initialValue: recipe.notes)
////            _tags = State(initialValue: recipe.tags)
////        } else {
////            // Initialize for a new recipe
////            _title = State(initialValue: "")
////            _author = State(initialValue: "")
////            _recipeDescription = State(initialValue: "")
////            _timeRequired = State(initialValue: "")
////            _selectedCategories = State(initialValue: [])
////            _servings = State(initialValue: "")
////            _difficultyLevel = State(initialValue: nil)
////            _calories = State(initialValue: "")
////            _ingredients = State(initialValue: [])
////            _instructions = State(initialValue: [])
////            _notes = State(initialValue: [])
////            _tags = State(initialValue: [])
////        }
////    }
////    
////
////    var body: some View {
////        Form {
////            Section(header: Text("Recipe Details")) {
////                TextField("Title", text: $title)
////                
////                TextField("Author", text: $author)
////                
////                TextField("Description", text: $recipeDescription, axis: .vertical)
////                
////                Picker("Category", selection: $selectedCategories) {
////                    Text("").tag(nil as RecipeCategory?)
////                    ForEach(categories, id: \.self) { category in
////                        Text(category.title).tag(category.title)
////                    }
////                }
////                
////                // See https://stackoverflow.com/questions/58733003/how-to-create-textfield-that-only-accepts-numbers
////                TextField("Time Required (Minutes)", text: $timeRequired)
////                    .keyboardType(.numberPad) // Display a number pad keyboard
////                    .onReceive(Just(timeRequired)) { newValue in
////                        let filtered = newValue.filter { "0123456789".contains($0) }
////                        if filtered != newValue {
////                            self.timeRequired = filtered
////                        }
////                    }
////                
////                TextField("Servings", text: $servings)
////                    .keyboardType(.numberPad) // Display a number pad keyboard
////                    .onReceive(Just(servings)) { newValue in
////                        let filtered = newValue.filter { "0123456789".contains($0) }
////                        if filtered != newValue {
////                            self.servings = filtered
////                        }
////                    }
////                
////                TextField("Calories per Serving", text: $calories)
////                    .keyboardType(.numberPad) // Display a number pad keyboard
////                    .onReceive(Just(calories)) { newValue in
////                        let filtered = newValue.filter { "0123456789".contains($0) }
////                        if filtered != newValue {
////                            self.calories = filtered
////                        }
////                    }
////                
////                Picker("Difficulty Level", selection: $difficultyLevel) {
////                    Text("").tag(nil as Int?)
////                    ForEach(1...10, id: \.self) { level in
////                        Text(String(level)).tag(level)
////                    }
////                }
////
////            }
////            
////            Section(header: Text("Ingredients")) {
////                ForEach($ingredients.indices, id: \.self) { index in
////                    HStack {
////                        TextField("Amount", value: $ingredients[index].amount, format: .number)
////                            .keyboardType(.decimalPad)
////                            .frame(maxWidth: 5)
////                        
////                        Picker(selection: $ingredients[index].unit, label: EmptyView()) {
////                            ForEach(Constants.IngredientUnits, id: \.self) { unit in
////                                Text(unit).tag(unit)
////                            }
////                        }
////                        .pickerStyle(MenuPickerStyle())
////                        
////                        TextField("Name", text: $ingredients[index].name).frame(maxWidth: .infinity)
////                    }
////                }
////                .onDelete(perform: deleteIngredient)
////
////                Button(action: addIngredient) {
////                    Text("Add Ingredient")
////                }
////            }
////            
////            Section(header: Text("Instructions")) {
////                ForEach($instructions.indices, id: \.self) { index in
////                    VStack {
////                        TextField("Title", text: $instructions[index].title).fontWeight(.bold)
////                        TextField("Instructions for this step...", text: $instructions[index].instruction, axis: .vertical)
////                    }
////                    .padding(.vertical, 8)
////                }
////                .onDelete(perform: deleteStep)
////
////                Button(action: addStep) {
////                    Text("Add Step")
////                }
////            }
////            
////            Section {
////                Button(action: addRecipe) {
////                    Text("\(recipe != nil ? "Save" : "Add") Recipe")
////                }
////            }
////        }.navigationBarTitle("\(recipe != nil ? "Save" : "Add") Recipe", displayMode: .inline)
////    }
////    
////    func addRecipe() {
////        withAnimation {
////            if (!title.isEmpty && !author.isEmpty) {
////                let newRecipe = Recipe(
////                    dateAdded: Date(),
////                    lastView: Date(),
////                    title: title,
////                    author: author,
////                    recipeDescription: !recipeDescription.isEmpty ? recipeDescription : nil as String? ,
////                    categories: selectedCategories,
////                    ingredients: [],
////                    instructions: [],
////                    timeRequired: Int(timeRequired),
////                    servings: Int(servings),
////                    difficultyLevel: difficultyLevel,
////                    calories: Int(calories),
////                    notes: notes,
////                    tags: tags
////                )
////                modelContext.insert(newRecipe)
////                
////                for ing in ingredients {
////                    let newIng = Ingredient(recipe: newRecipe, amount: ing.amount, unit: ing.unit, name: ing.name)
////                    modelContext.insert(newIng)
////                }
////                
////                for step in instructions {
////                    let newStep = Step(recipe: newRecipe, stepNum: step.stepNum, title: step.title, instruction: step.instruction)
////                    modelContext.insert(newStep)
////                }
////            }
////        }
////    }
////    
////    private func addIngredient() {
////        ingredients.append(TemporaryIngredient(id: String(ingredients.count), amount: 0, unit: "cup", name: ""))
////    }
////
////    private func deleteIngredient(at offsets: IndexSet) {
////        ingredients.remove(atOffsets: offsets)
////    }
////    
////    private func addStep() {
////        instructions.append(TemporaryStep(id: String(instructions.count), stepNum: instructions.count + 1, title: "Step \(instructions.count + 1)", instruction: ""))
////    }
////
////    private func deleteStep(at offsets: IndexSet) {
////        instructions.remove(atOffsets: offsets)
////    }
////    
////    struct TemporaryIngredient: Identifiable {
////        var id: String
////        var amount: Float
////        var unit: String
////        var name: String
////
////        init(ingredient: Ingredient) {
////            self.id = ingredient.recipeAndName
////            self.amount = ingredient.amount
////            self.unit = ingredient.unit
////            self.name = ingredient.name
////        }
////        
////        init(id: String, amount: Float, unit: String, name: String) {
////            self.id = id
////            self.amount = amount
////            self.unit = unit
////            self.name = name
////        }
////    }
////
////    struct TemporaryStep: Identifiable {
////        var id: String
////        var stepNum: Int
////        var title: String
////        var instruction: String
////
////        init(step: Step) {
////            self.id = step.recipeAndStepNum
////            self.stepNum = step.stepNum
////            self.title = step.title
////            self.instruction = step.instruction
////        }
////        
////        init(id: String, stepNum: Int, title: String, instruction: String) {
////            self.id = id
////            self.stepNum = stepNum
////            self.title = title
////            self.instruction = instruction
////        }
////    }
////}
////
////#Preview {
////    RecipeForm(recipe: nil)
////}
//
//
//struct RecipeEditor: View {
//    let recipe: Recipe?
//    
//    private var editorTitle: String {
//        recipe == nil ? "Add Recipe" : "Edit Recipe"
//    }
//    
////    @State private var name = ""
////    @State private var selectedDiet = Animal.Diet.herbivorous
////    @State private var selectedCategory: AnimalCategory?
//    
//    @State private var title: String = ""
//    @State private var author: String = ""
//    @State private var recipeDescription: String = ""
//    @State private var timeRequired: String = ""
//    @State private var selectedCategories: [RecipeCategory]
//    @State private var servings: String = ""
//    @State private var difficultyLevel: Int?
//    @State private var calories: String = ""
//    @State private var ingredients: [TemporaryIngredient] = []
//    @State private var instructions: [TemporaryStep] = []
//    @State private var notes: [String] = []
//    @State private var tags: [String] = []
//    
//    @Environment(\.dismiss) private var dismiss
//    @Environment(\.modelContext) private var modelContext
//    
//    @Query(sort: \RecipeCategory.title) private var categories: [RecipeCategory]
//    
//    var body: some View {
//        NavigationStack {
//            Form {
//                Section(header: Text("Recipe Details")) {
//                    TextField("Title", text: $title)
//    
//                    TextField("Author", text: $author)
//    
//                    TextField("Description", text: $recipeDescription, axis: .vertical)
//    
//                    Picker("Category", selection: $selectedCategories) {
//                        Text("").tag(nil as RecipeCategory?)
//                        ForEach(categories, id: \.self) { category in
//                            Text(category.title).tag(category.title)
//                        }
//                    }
//    
//                    // See https://stackoverflow.com/questions/58733003/how-to-create-textfield-that-only-accepts-numbers
//                    TextField("Time Required (Minutes)", text: $timeRequired)
//                        .keyboardType(.numberPad) // Display a number pad keyboard
//                        .onReceive(Just(timeRequired)) { newValue in
//                            let filtered = newValue.filter { "0123456789".contains($0) }
//                            if filtered != newValue {
//                                self.timeRequired = filtered
//                            }
//                        }
//    
//                    TextField("Servings", text: $servings)
//                        .keyboardType(.numberPad) // Display a number pad keyboard
//                        .onReceive(Just(servings)) { newValue in
//                            let filtered = newValue.filter { "0123456789".contains($0) }
//                            if filtered != newValue {
//                                self.servings = filtered
//                            }
//                        }
//    
//                    TextField("Calories per Serving", text: $calories)
//                        .keyboardType(.numberPad) // Display a number pad keyboard
//                        .onReceive(Just(calories)) { newValue in
//                            let filtered = newValue.filter { "0123456789".contains($0) }
//                            if filtered != newValue {
//                                self.calories = filtered
//                            }
//                        }
//    
//                    Picker("Difficulty Level", selection: $difficultyLevel) {
//                        Text("").tag(nil as Int?)
//                        ForEach(1...10, id: \.self) { level in
//                            Text(String(level)).tag(level)
//                        }
//                    }
//    
//                }
//    
//                Section(header: Text("Ingredients")) {
//                    ForEach($ingredients.indices, id: \.self) { index in
//                        HStack {
//                            TextField("Amount", value: $ingredients[index].amount, format: .number)
//                                .keyboardType(.decimalPad)
//                                .frame(maxWidth: 5)
//    
//                            Picker(selection: $ingredients[index].unit, label: EmptyView()) {
//                                ForEach(Constants.IngredientUnits, id: \.self) { unit in
//                                    Text(unit).tag(unit)
//                                }
//                            }
//                            .pickerStyle(MenuPickerStyle())
//    
//                            TextField("Name", text: $ingredients[index].name).frame(maxWidth: .infinity)
//                        }
//                    }
//                    .onDelete(perform: deleteIngredient)
//    
//                    Button(action: addIngredient) {
//                        Text("Add Ingredient")
//                    }
//                }
//    
//                Section(header: Text("Instructions")) {
//                    ForEach($instructions.indices, id: \.self) { index in
//                        VStack {
//                            TextField("Title", text: $instructions[index].title).fontWeight(.bold)
//                            TextField("Instructions for this step...", text: $instructions[index].instruction, axis: .vertical)
//                        }
//                        .padding(.vertical, 8)
//                    }
//                    .onDelete(perform: deleteStep)
//    
//                    Button(action: addStep) {
//                        Text("Add Step")
//                    }
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    Text(editorTitle)
//                }
//                
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("Save") {
//                        withAnimation {
//                            save()
//                            dismiss()
//                        }
//                    }
//                    // Require a category to save changes.
//                    .disabled($title.isEmpty || $author.isEmpty || $selectedCategories.count == 0)
//                }
//                
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Cancel", role: .cancel) {
//                        dismiss()
//                    }
//                }
//            }
//            .onAppear {
//                if let recipe {
//                    // Edit the incoming recipe.
//                    title = recipe.title
//                    author = recipe.author
//                    recipeDescription = recipe.recipeDescription
//                    timeRequired = recipe.timeRequired
//                    selectedCategories = recipe.categories
//                    servings = recipe.servings
//                    difficultyLevel = recipe.difficultyLevel
//                    calories = recipe.calories
//                    ingredients = recipe.ingredients.map { TemporaryIngredient(ingredient: $0)}
//                    instructions = recipe.instructions.map { TemporaryStep(step: $0)}
//                    notes = recipe.notes
//                    tags = recipe.tags
//                }
//            }
//            #if os(macOS)
//            .padding()
//            #endif
//        }
//    }
//    
//    private func addIngredient() {
//        ingredients.append(TemporaryIngredient(id: String(ingredients.count), amount: 0, unit: "cup", name: ""))
//    }
//
//    private func deleteIngredient(at offsets: IndexSet) {
//        ingredients.remove(atOffsets: offsets)
//    }
//
//    private func addStep() {
//        instructions.append(TemporaryStep(id: String(instructions.count), stepNum: instructions.count + 1, title: "Step \(instructions.count + 1)", instruction: ""))
//    }
//
//    private func deleteStep(at offsets: IndexSet) {
//        instructions.remove(atOffsets: offsets)
//    }
//    
//    private func save() {
//        if let recipe {
//            // Edit the recipe.
//            recipe.title = title
//            recipe.author = author
//            recipe.recipeDescription = recipeDescription
//            recipe.timeRequired = Int(timeRequired)
//            recipe.categories = selectedCategories
//            recipe.servings = Int(servings)
//            recipe.difficultyLevel = difficultyLevel
//            recipe.calories = Int(calories)
//            recipe.ingredients = []
//            recipe.instructions = []
//            recipe.notes = recipe.notes
//            recipe.tags = recipe.tags
//            
//            for ing in ingredients {
//                let newIng = Ingredient(recipe: recipe, amount: ing.amount, unit: ing.unit, name: ing.name)
//                modelContext.insert(newIng)
//            }
//
//            for step in instructions {
//                let newStep = Step(recipe: recipe, stepNum: step.stepNum, title: step.title, instruction: step.instruction)
//                modelContext.insert(newStep)
//            }
//        } else {
//            // Add a recipe.
//            let newRecipe = Recipe(
//                dateAdded: Date(),
//                lastView: Date(),
//                title: title,
//                author: author,
//                recipeDescription: !recipeDescription.isEmpty ? recipeDescription : nil as String? ,
//                categories: selectedCategories,
//                ingredients: [],
//                instructions: [],
//                timeRequired: Int(timeRequired),
//                servings: Int(servings),
//                difficultyLevel: difficultyLevel,
//                calories: Int(calories),
//                notes: notes,
//                tags: tags
//            )
//            modelContext.insert(newRecipe)
//
//            for ing in ingredients {
//                let newIng = Ingredient(recipe: newRecipe, amount: ing.amount, unit: ing.unit, name: ing.name)
//                modelContext.insert(newIng)
//            }
//
//            for step in instructions {
//                let newStep = Step(recipe: newRecipe, stepNum: step.stepNum, title: step.title, instruction: step.instruction)
//                modelContext.insert(newStep)
//            }
//        }
//    }
//    
//    struct TemporaryIngredient: Identifiable {
//        var id: String
//        var amount: Float
//        var unit: String
//        var name: String
//
//        init(ingredient: Ingredient) {
//            self.id = ingredient.recipeAndName
//            self.amount = ingredient.amount
//            self.unit = ingredient.unit
//            self.name = ingredient.name
//        }
//
//        init(id: String, amount: Float, unit: String, name: String) {
//            self.id = id
//            self.amount = amount
//            self.unit = unit
//            self.name = name
//        }
//    }
//
//    struct TemporaryStep: Identifiable {
//        var id: String
//        var stepNum: Int
//        var title: String
//        var instruction: String
//
//        init(step: Step) {
//            self.id = step.recipeAndStepNum
//            self.stepNum = step.stepNum
//            self.title = step.title
//            self.instruction = step.instruction
//        }
//
//        init(id: String, stepNum: Int, title: String, instruction: String) {
//            self.id = id
//            self.stepNum = stepNum
//            self.title = title
//            self.instruction = instruction
//        }
//    }
//}
//
//#Preview("Add animal") {
//    ModelContainerPreview(ModelContainer.sample) {
//        AnimalEditor(animal: nil)
//    }
//}
//
//#Preview("Edit animal") {
//    ModelContainerPreview(ModelContainer.sample) {
//        AnimalEditor(animal: .kangaroo)
//    }
//}
