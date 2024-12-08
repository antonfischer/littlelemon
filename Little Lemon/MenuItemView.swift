//
//  MenuItemView.swift
//  Little Lemon
//
//  Created by Fischer, Anton on 08/12/2024.
//

import SwiftUI
import CoreData

struct MenuItemView: View {
    let dish: Dish
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: dish.image!)) { image in
                image.image?.resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            .frame(width: 200, height: 200)
            
            Text(dish.title!)
                
            Spacer()
        }
    }
}
