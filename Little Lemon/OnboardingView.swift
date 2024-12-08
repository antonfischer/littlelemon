//
//  OnboardingView.swift
//  Little Lemon
//
//  Created by Fischer, Anton on 07/12/2024.
//

import SwiftUI

let kFirstName = "firstNameKey"
let kLastName = "lastNameKey"
let kEmail = "emailKey"
let kIsLoggedIn = "kIsLoggedInKey"

struct OnboardingView: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 16) {
                NavigationLink(destination: HomeView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                LabeledContent("First Name") {
                    TextField("First Name", text: $firstName)
                        .multilineTextAlignment(.trailing)
                }
                LabeledContent("Last Name") {
                    TextField("Last Name", text: $lastName)
                        .multilineTextAlignment(.trailing)
                }
                LabeledContent("Email") {
                    TextField("Email", text: $email)
                        .multilineTextAlignment(.trailing)
                }
                Button("Register") {
                    if (!firstName.isEmpty && !lastName.isEmpty && !email.isEmpty) {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        
                        isLoggedIn = true
                    } else {
                        print("Please fill out all fields")
                    }
                }
                .buttonBorderShape(.roundedRectangle(radius: 6.0))
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .onAppear() {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
            .padding()
            .navigationTitle("Onboarding")
        }
    }
}

#Preview {
    OnboardingView()
}
