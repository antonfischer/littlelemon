//
//  HeroView.swift
//  Little Lemon
//
//  Created by Fischer, Anton on 08/12/2024.
//

import SwiftUI

struct HeroView: View {
    var hasSearchField: Bool = false
    @Binding var searchText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Little Lemon")
                .font(.system(size: 34, weight: .bold, design: .serif))
                .foregroundStyle(Color("Lemon"))
            
            
            HStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 24){
                    Text("Chicago")
                        .font(.system(size: 20, weight: .bold, design: .serif))
                    Text("We are a family-owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .font(.subheadline)
                }
                
                Image("Dish-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .foregroundStyle(.white)
            
            if hasSearchField {
                TextField("Search menu", text: $searchText)
                
                    .textFieldStyle(.roundedBorder)
                    .padding(.top, 20)
            }
        }
        .padding()
        .background(
            Color("AccentColor")
        )    }
}

#Preview {
    HeroView(hasSearchField: false, searchText: .constant(""))
}
