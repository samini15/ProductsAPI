//
//  SliderView.swift
//  ProductsAPI
//
//  Created by Shayan Amini on 11/10/2023.
//

import SwiftUI

struct SliderView: View {
    @Binding var sliderValue: Double
    
    let label: String
    let minValue: Double
    let maxValue: Double
    
    var body: some View {
        VStack {
            HStack {
                Text(label)
                Slider(value: $sliderValue, in: minValue...maxValue) {
                    
                } minimumValueLabel: {
                    Text(String(Int(minValue)))
                } maximumValueLabel: {
                    Text(String(Int(maxValue)))
                }
            }
            Text("\(Int(sliderValue))$")
        }
    }
}

#Preview {
    SliderView(sliderValue: .constant(50.0), label: "Price", minValue: 0, maxValue: 3000)
}
