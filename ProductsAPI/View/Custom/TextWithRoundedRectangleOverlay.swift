//
//  TextWithRoundedRectangleOverlay.swift
//  ProductsAPI
//
//  Created by Shayan Amini on 08/10/2023.
//

import SwiftUI

struct TextWithRoundedRectangleOverlay: View {
    
    let displayText: String
    let color: Color
    
    var body: some View {
        Text(displayText)
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.horizontal, 13)
            .padding(.vertical, 5)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .fill(color.opacity(0.3))
            }
            .shadow(radius: 20, x: 0, y: 5)
    }
}

#Preview {
    TextWithRoundedRectangleOverlay(displayText: "Product", color: .blue)
}
