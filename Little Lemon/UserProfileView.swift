//
//  UserProfileView.swift
//  Little Lemon
//
//  Created by Fischer, Anton on 07/12/2024.
//

import SwiftUI

struct UserProfileView: View {
    let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    let lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    let email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @Environment(\.presentationMode) var presentation
    @State var isLoggedOut = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Personal information")
            Image("profile-image-placeholder")
            
            Text(firstName)
            Text(lastName)
            Text(email)
            
            NavigationLink(destination: OnboardingView(), isActive: $isLoggedOut) {
                EmptyView()
            }.transition(.move(edge: .trailing))
            
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                // this is a cheap hack. Currently, it doesn't work well. Might be a better solution to have the onboarding presented like this
                /*
                 if !isLoggedIn || !hasCompletedOnboarding {
                             OnboardingView()
                         } else {
                             TabView {
                                 // Your tab view content
                                 UserPreferencesView()
                                 // Other tabs...
                             }
                         }
                 
                 
                */
                
                isLoggedOut = true
                
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle(radius: 6.0))
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    UserProfileView()
}
