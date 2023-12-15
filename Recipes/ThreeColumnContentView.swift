//
//  ThreeColumnContentView.swift
//  Recipes
//
//  Created by Zach Barton on 12/11/23.
//

//import SwiftUI
//import SwiftData
//
//struct ThreeColumnContentView: View {
//    @Environment(NavigationContext.self) private var navigationContext
//    @Environment(\.modelContext) private var modelContext
//    
//    var body: some View {
//        @Bindable var navigationContext = navigationContext
//        NavigationSplitView(columnVisibility: $navigationContext.columnVisibility) {
//            AnimalCategoryListView()
//                .navigationTitle(navigationContext.sidebarTitle)
//        } content: {
//            AnimalListView(animalCategoryName: navigationContext.selectedAnimalCategoryName)
//                .navigationTitle(navigationContext.contentListTitle)
//        } detail: {
//            NavigationStack {
//                AnimalDetailView(animal: navigationContext.selectedAnimal)
//            }
//        }
//    }
//}
//
//#Preview {
//    ModelContainerPreview(ModelContainer.sample) {
//        ThreeColumnContentView()
//            .environment(NavigationContext())
//    }
//}
