//
//  ContentView.swift
//  Recipes
//
//  Created by Zach Barton on 12/4/23.
//

import SwiftUI
import SwiftData
import MarkdownUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.horizontalSizeClass) private var sizeClass
    @Query private var categories: [RecipeCategory]
    @Query(sort: [SortDescriptor(\Recipe.dateAdded)] )
    private var allRecipes: [Recipe]
    
    @State private var unselectedCategories: Set<RecipeCategory> = []
    @State private var favoritesFilterActive = false
    @State private var searchText = ""
    
    @State private var selectedRecipe: Recipe?
    @State private var recipeToEdit: Recipe?
    
    @State private var showingNewRecipeForm = false
    @State private var showingEditRecipeForm = false
    @State private var showingNewCategoryForm = false
    
    @State private var sidebarVisibility = NavigationSplitViewVisibility.doubleColumn
    @State private var preferredColumn = NavigationSplitViewColumn.detail
    
    

    var body: some View {
        NavigationSplitView (columnVisibility: $sidebarVisibility, preferredCompactColumn: $preferredColumn) {
            VStack {
                Text("Filter Recipes")
                    .font(.title)
                    .bold()
                Divider()
                VStack {
                    HStack {
                        Text("Favorites")
                        Spacer()
                        // Show a checkmark for selected items
                        if favoritesFilterActive {
                            Image(systemName: "checkmark")
                        }
                    }.contentShape(Rectangle()) // This ensures the tap is registered across the entire row
                        .onTapGesture {
                            // Toggle selection when the row is tapped
                            favoritesFilterActive.toggle()
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                    Divider()
                        .padding(.leading)
                }.padding(.top, 20)
                
                Text("Categories")
                    .bold()
                    .padding(.top, 30)
                List(categories, selection: $unselectedCategories) { category in
                    HStack {
                        Text(category.title)
                        Spacer()
                        // Show a checkmark for selected items
                        if !unselectedCategories.contains(category) {
                            Image(systemName: "checkmark")
                        }
                    }.contentShape(Rectangle()) // This ensures the tap is registered across the entire row
                        .onTapGesture {
                            // Toggle selection when the row is tapped
                            if unselectedCategories.contains(category) {
                                unselectedCategories.remove(category)
                            } else {
                                unselectedCategories.insert(category)
                            }
                        }
                }
                .listStyle(PlainListStyle())
                Spacer()
                if UIDevice.current.userInterfaceIdiom == .phone {
                    // This view will only appear on iPhone
                    NavigationLink("View Recipes") {
                        contentView
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)  // Make the button expand to the full width
                    .padding()  // Add some padding inside the button
                    .background(.selection)  // Set the background color to blue
                    .foregroundColor(.white)  // Set the text color to white
                    .cornerRadius(10)
                    .padding()
                        }
                HStack {
                    Button(action: showCategoryForm) {
                        Label("Add Category", systemImage: "folder.badge.plus")
                    }.sheet(isPresented: $showingNewCategoryForm) {
                        CategoryEditor(category: nil)
                    }.padding(.leading, 20)
                    Spacer()
                }
            }
        } content: {
            contentView
        } detail: {
            Button("Load Sample Data") {
                initializeData()
            }
        }
        
    }
    
    private var contentView: some View {
        VStack {
            TextField("Search", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(10)
            List {
                ForEach(filteredRecipes()) {recipe in
                    NavigationLink {
                        ScrollView {
                            VStack {
                                HStack (spacing: 15) {
                                    Spacer()
                                    Button(action: { withAnimation {
                                        showingEditRecipeForm.toggle()
                                    } }, label: { 
                                        Image(systemName: "pencil")
                                    })
                                    Divider()
                                    Button(action: { recipe.isFavorited.toggle() }, label: { HStack {
                                        Image(systemName: recipe.isFavorited ? "star.fill" : "star")
                                    } })
                                }
                                HStack {
                                    RecipeContentView(recipe: recipe)
                                    Spacer()
                                }
                                Spacer()
                            }
                            .padding(.horizontal, 50)
                            .sheet(isPresented: $showingEditRecipeForm) {
                                RecipeEditor(recipe: recipe)
                            }
                        }
                    } label: {
                        HStack {
                            Text(recipe.title)
                            Spacer()
                            if (recipe.isFavorited) {
                                Image(systemName: "star.fill").foregroundColor(.primary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
        }
        .sheet(isPresented: $showingNewRecipeForm) {
            RecipeEditor(recipe: $recipeToEdit.wrappedValue)
        }
        .toolbar {
            //                    ToolbarItem(placement: .navigationBarTrailing) {
            //                        EditButton()
            //                    }
            ToolbarItem {
                Button(action: showNewRecipeForm) {
                    Label("Add Recipe", systemImage: "plus")
                }
            }
        }
    }
    
    private func filteredRecipes() -> [Recipe] {
        var filtered = favoritesFilterActive ? allRecipes.filter { $0.isFavorited } : allRecipes
        let includedCategories = categories.filter { !unselectedCategories.contains($0) }
        filtered = filtered.filter {
            var includeRecipe = false
            for cat in $0.categories {
                if (includedCategories.contains(cat)) {
                    includeRecipe = true
                }
            }
            return includeRecipe
        }
        if (searchText != "") {
            filtered = filtered.filter {
                let rec = $0
                return "\(rec.title)\(rec.author)\(String(describing: rec.recipeDescription))".uppercased().contains(searchText.uppercased())
            }
        }
        return filtered
    }
    
    private func showNewRecipeForm() {
        withAnimation {
            showingNewRecipeForm.toggle()
        }
    }
    
    private func showCategoryForm() {
        withAnimation {
            showingNewCategoryForm.toggle()
        }
    }
    
    private func initializeData() {
        for recipe in allRecipes {
            modelContext.delete(recipe)
        }
        for category in sampleCategories {
            modelContext.insert(category)
        }
        for recipe in sampleRecipes {
            let rec = recipe.recipe
            modelContext.insert(rec)
            for cat in recipe.categories {
                let catModel = sampleCategories.filter { $0.title == cat }
                if (catModel.count > 0) {
                    rec.categories.append(catModel[0])
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(allRecipes[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Recipe.self, inMemory: true)
}

