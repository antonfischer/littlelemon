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
        MenuView()
            .environment(\.managedObjectContext, persistence.container.viewContext)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HomeView()
}
