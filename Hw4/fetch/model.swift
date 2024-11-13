//
//  model.swift
//  Hw4
//
//  Created by david david on 07.11.2024.
//

import Foundation

/// A model representing a cat image.
struct Cat: Codable {
    let id: String
    let url: String
}

/// A model representing a cat breed.
struct Breed: Codable {
    let id: String
    let name: String
    let temperament: String?
    let origin: String?
}

struct CatBreed: Codable {
    let id: String
    let url: String
    let name: String
}
