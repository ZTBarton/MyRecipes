////
////  RecipeCategoryListView.swift
////  Recipes
////
////  Created by Zach Barton on 12/11/23.
////
//
//import SwiftUI
//import SwiftData
//
//struct RecipeCategoryListView: View {
//    @Environment(NavigationContext.self) private var navigationContext
//    @Environment(\.modelContext) private var modelContext
//    @Query(sort: \RecipeCategory.title) private var categories: [RecipeCategory]
//    @State private var isReloadPresented = false
//
//    var body: some View {
//        @Bindable var navigationContext = navigationContext
//        List(selection: $navigationContext.selectedRecipeCategories) {
////            #if os(macOS)
////            Section(navigationContext.sidebarTitle) {
////                ListCategories(recipeCategories: categories)
////            }
////            #else
//            ListCategories(recipeCategories: categories)
////            #endif
//        }
//        .alert("Reload Sample Data?", isPresented: $isReloadPresented) {
//            Button("Yes, reload sample data", role: .destructive) {
//                reloadSampleData()
//            }
//        } message: {
//            Text("Reloading the sample data deletes all changes to the current data.")
//        }
//        .toolbar {
//            Button {
//                isReloadPresented = true
//            } label: {
//                Label("", systemImage: "arrow.clockwise")
//                    .help("Reload sample data")
//            }
//        }
//        .task {
//            if categories.isEmpty {
//                RecipeCategory.insertSampleData(modelContext: modelContext)
//            }
//        }
//    }
//    
//    @MainActor
//    private func reloadSampleData() {
//        navigationContext.selectedRecipe = nil
//        navigationContext.selectedRecipeCategories = []
//        RecipeCategory.reloadSampleData(modelContext: modelContext)
//    }
//}
//
//private struct ListCategories: View {
//    var recipeCategories: [RecipeCategory]
//    
//    var body: some View {
//        ForEach(recipeCategories) { cat in
//            NavigationLink(cat.title, value: cat)
//        }
//    }
//}
//
////#Preview("RecipeCategoryListView") {
////    ModelContainerPreview(ModelContainer.sample) {
////        NavigationStack {
////            AnimalCategoryListView()
////        }
////        .environment(NavigationContext())
////    }
////}
////
////#Preview("ListCategories") {
////    ModelContainerPreview(ModelContainer.sample) {
////        NavigationStack {
////            List {
////                ListCategories(animalCategories: [.amphibian, .bird])
////            }
////        }
////        .environment(NavigationContext())
////    }
////}
