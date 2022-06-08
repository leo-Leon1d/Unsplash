//
//  Model.swift
//  Unsplash
//
//  Created by Леонид Исраелян on 15.05.2022.
//

import Foundation

struct Model: Decodable {
    let total: Int
    let total_pages: Int
    let results: [Results]
}

struct Results: Decodable {
    let id: String
    let urls: Urls
}

struct Urls: Decodable {
    let small: String
}
