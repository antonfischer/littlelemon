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
    
    func buildSortDescriptors() -> [NSSortDescriptor] {

        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                 selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText == "" {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
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
        VStack {
            Text("Title")
            Text("Chicago")
            Text("Description")
            
            TextField("Search menu", text: $searchText)
                .padding()
            
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        NavigationLink(destination: MenuItemView(dish: dish)) {
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
                }
            }
        }
        .onAppear {
            getMenuData()
        }
    }
}

#Preview {
    MenuView()
}
