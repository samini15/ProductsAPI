//
//  AdvanceFilterSheetView.swift
//  ProductsAPI
//
//  Created by Shayan Amini on 10/10/2023.
//

import SwiftUI
import SwiftData

struct AdvanceFilterSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: AdvanceFilterViewModel
    
    @SceneStorage("AdvanceFilterSheetView.price") private var price = Content.defaultPrice
    @SceneStorage("AdvanceFilterSheetView.selectedCategory") private var selectedCategory = Content.defaultCategory
    @SceneStorage("AdvanceFilterSheetView.selectedBrand") private var selectedBrand = Content.defaultBrand
    @SceneStorage("AdvanceFilterSheetView.selectedRating") private var selectedRating = Content.defaultRating
    
    @Query(sort: \ProductEntity.category) private var allProducts: [ProductEntity]
    
    var body: some View {
        
        NavigationStack {
            Form {
                SliderView(sliderValue: $price, label: "Price", minValue: 0, maxValue: Double(getTheMostExpensiveProduct() ?? 3000))
                Picker("Category", selection: $selectedCategory) {
                    ForEach(Array(getAllCategories()), id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                Picker("Brand", selection: $selectedBrand) {
                    ForEach(Array(getAllBrands()), id: \.self) { brand in
                        Text(brand).tag(brand)
                    }
                }
                HStack {
                    Text("Rating")
                    Picker("Rating", selection: $selectedRating) {
                        Text(String(1)).tag(String(1))
                        Text(String(2)).tag(String(2))
                        Text(String(3)).tag(String(3))
                        Text(String(4)).tag(String(4))
                        Text(String(5)).tag(String(5))
                    }.pickerStyle(.segmented)
                }
            }
            .navigationTitle("Advance Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("apply") {
                        setFilterCriteria()
                        dismiss()
                    }
                }
            }
            
            Button("Reinitialize") {
                reinitializeFilter()
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .shadow(radius: 10, x: 0, y: 5)
        }
    }
    
    private func setFilterCriteria() {
        viewModel.allProducts = self.allProducts
        viewModel.applyFilter(price: Int(self.price), category: selectedCategory, brand: selectedBrand, rating: selectedRating)
    }
    
    private func reinitializeFilter() {
        viewModel.initializeFilter()
        self.price = Content.defaultPrice
        self.selectedCategory = Content.defaultCategory
        self.selectedBrand = Content.defaultBrand
        self.selectedRating = Content.defaultRating
    }
    
    private func getTheMostExpensiveProduct() -> Int? {
        return allProducts.map {
            $0.price
        }.max()
    }
    
    private func getAllCategories() -> Set<String> {
        return Set(allProducts.map { $0.category })
    }
    
    private func getAllBrands() -> Set<String> {
        return Set(allProducts.map { $0.brand })
    }
}

#Preview {
    AdvanceFilterSheetView()
}
