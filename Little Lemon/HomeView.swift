//
//  HomeView.swift
//  Little Lemon
//
//  Created by Fischer, Anton on 07/12/2024.
//

import SwiftUI

struct HomeView: View {
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView {
            Tab("Menu", systemImage: "list.dash") {
                MenuView()
                    .environment(\.managedObjectContext, persistence.container.viewContext)
            }
            
            Tab("Profile", systemImage: "square.and.pencil") {
                UserProfileView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}
