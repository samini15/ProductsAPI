//
//  ProductsAPIApp.swift
//  ProductsAPI
//
//  Created by Shayan Amini on 08/10/2023.
//

import SwiftUI
import SwiftData

@main
struct ProductsAPIApp: App {
    @StateObject var productViewModel: ProductViewModel = ProductViewModel(productService: ProductService())
    @StateObject var advanceFilterViewModel: AdvanceFilterViewModel = AdvanceFilterViewModel()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ProductEntity.self,
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
            ProductListView()
        }
        .modelContainer(sharedModelContainer)
        .environmentObject(productViewModel)
        .environmentObject(advanceFilterViewModel)
    }
}
