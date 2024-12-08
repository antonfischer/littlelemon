//
//  MenuView.swift
//  Little Lemon
//
//  Created by Fischer, Anton on 07/12/2024.
//

import SwiftUI
import CoreData

struct MenuView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    @State var selectedFilter = ""
    
    func buildSortDescriptors() -> [NSSortDescriptor] {

        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        var predicates: [NSPredicate] = []
        
        // Predicate for search text
        if !searchText.isEmpty {
            predicates.append(NSPredicate(format: "title CONTAINS[cd] %@", searchText))
        }
        
        // Predicate for selected filter
        if !selectedFilter.isEmpty {
            predicates.append(NSPredicate(format: "category == %@", selectedFilter))
        }
        
        // If no predicates, return a predicate that matches everything
        if predicates.isEmpty {
            return NSPredicate(value: true)
        }
        
        // Combine predicates with AND
        return NSCompoundPredicate(type: .and, subpredicates: predicates)
    }
    
    func getMenuData() {
        
        // To clear the database each time before saving the menu list again, on the first line of the getMenuData method, before any other code is executed, use the shared property of the PersistenceController and call the clear method on it. It will make sure that the database is cleared of all the Dish data before fetching and storing the new ones again.
        PersistenceController.shared.clear()
        
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                print("No data received")
                return
            }
            
            let decoder = JSONDecoder()
            
            // Attempt to decode the data into MenuList
            do {
                let menuList = try decoder.decode(MenuList.self, from: data)
                
                for menuItem in menuList.menu {
                    let dish = Dish(context: viewContext)
                    
                    // Map properties from MenuItem to Dish
                    dish.title = menuItem.title
                    dish.image = menuItem.image
                    dish.price = menuItem.price
                    dish.category = menuItem.category
                }
                        
                try? viewContext.save()
            } catch {
                // Handle any decoding errors
                print("Decoding error: \(error)")
            }
            
        }
        
        task.resume()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                HeroView(hasSearchField: true, searchText: $searchText)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Order for Delivery".uppercased())
                        .font(.headline)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(["starters", "mains", "desserts", "drinks"], id: \.self) { item in
                                FilterButton(selectedFilter: $selectedFilter, item: item)
                            }
                            
                            Spacer()
                        }
                    }
                }
                .padding()
                
                Divider()
                  
                FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                    List {
                        ForEach(dishes) { dish in
                            HStack(spacing: 16) {
                                AsyncImage(url: URL(string: dish.image!)) { image in
                                    image.image?.resizable()
                                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                }
                                .frame(width: 50, height: 50)
                                
                                Text("\(dish.title!)")
                                    .font(.headline)
                                Spacer()
                                Text("$\(dish.price!)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .onAppear {
                getMenuData()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.white)
            .toolbarBackgroundVisibility(.visible)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 32)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: UserProfileView()) {
                        Image("profile-image-placeholder")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                    }
                    
                }
            }
        }
    }
}

#Preview {
    MenuView()
}

struct FilterButton: View {
    @Binding var selectedFilter: String
    var item: String
    
    var body: some View {
        Button(item.uppercased()) {
            selectedFilter = item
        }
        .font(.system(size: 12, weight: selectedFilter == item ? .bold : .regular))
        .controlSize(.mini)
        .buttonStyle(.bordered)
    }
}
