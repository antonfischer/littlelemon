//
//  MenuView.swift
//  Little Lemon
//
//  Created by Fischer, Anton on 07/12/2024.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Text("Title")
            Text("Chicago")
            Text("Description")
            
            List {
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
            }
        }
    }
}

#Preview {
    MenuView()
}
