//
//  UserProfileView.swift
//  Little Lemon
//
//  Created by Fischer, Anton on 07/12/2024.
//

import SwiftUI

struct UserProfileView: View {
    @State var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State var lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State var email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @Environment(\.presentationMode) var presentation
    @State var isLoggedOut = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Personal information")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Avatar")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.secondary)
                        HStack(alignment: .center, spacing: 16) {
                            Image("profile-image-placeholder")
                                .resizable()
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())
                            
                            HStack(spacing: 8) {
                                Button("Change") {
                                    //
                                }
                                .buttonStyle(.borderedProminent)
                                .buttonBorderShape(.roundedRectangle(radius: 4))
                                .controlSize(.small)
                                
                                Button("Remove") {
                                    //
                                }
                                .buttonStyle(.bordered)
                                .controlSize(.small)
                                .buttonBorderShape(.roundedRectangle(radius: 4))
                            }
                            
                            
                        }
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
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Phone Number")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.secondary)
                        TextField("", text: .constant("177 15230"))
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    
                    NavigationLink(destination: OnboardingView(), isActive: $isLoggedOut) {
                        EmptyView()
                    }.transition(.move(edge: .trailing))
                    
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Email Notifications")
                        .font(.headline)
                    
                    ForEach(["Order Statuses", "Password Changes", "Special Offers", "Newsletter"], id: \.self) { item in
                        Toggle(isOn: .constant(true)) {
                            Text(item)
                                .font(.subheadline)
                        }
                        .tint(Color("AccentColor"))
                    }
                }
                
                Button {
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
                    
                } label: {
                    Text("Log Out")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Lemon"))
                        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                        
                }
                .tint(Color("Text"))
                
                HStack {
                    Button("Discard Changes") {
                        //
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 6))
                    
                    Spacer()
                    
                    Button("Save Changes") {
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 6))
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbarBackground(Color.white)
        .toolbarBackgroundVisibility(.visible)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    presentation.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .frame(width: 32, height: 32)
                        .background(Color("AccentColor"))
                        .clipShape(Circle())
                    
                }
            }
            
            ToolbarItem(placement: .principal) {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 32)
            }
        }
    }
}

#Preview {
    UserProfileView()
}
