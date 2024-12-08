//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Fischer, Anton on 08/12/2024.
//

import Foundation

struct MenuItem: Decodable {
    let id = UUID()
    let title: String
    let image: String
    let price: String
    let category: String
    let description: String
}
