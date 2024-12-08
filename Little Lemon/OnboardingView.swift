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
            VStack {
                HeroView(hasSearchField: false, searchText: .constant("Whatever – not used"))
                VStack(alignment: .center, spacing: 16) {
                    NavigationLink(destination: HomeView(), isActive: $isLoggedIn) {
                        EmptyView()
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("First Name")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.secondary)
                        TextField("", text: $firstName)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Last Name")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.secondary)
                        TextField("", text: $lastName)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Email")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.secondary)
                        TextField("", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                    }
                    
                    
                }
                .padding()
                
                Spacer()
                
                Button {
                    if (!firstName.isEmpty && !lastName.isEmpty && !email.isEmpty) {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                        
                        isLoggedIn = true
                    } else {
                        print("Please fill out all fields")
                    }
                } label: {
                    Text("Register")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Lemon"))
                        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                        
                }
                .tint(Color("Text"))
                .padding()
                
                
            }
            .onAppear() {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbarBackground(Color.white)
            .toolbarBackgroundVisibility(.visible)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 32)
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
