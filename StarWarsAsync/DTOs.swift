//
//  DTOs.swift
//  StarWarsAsync
//
//  Created by Vikram Kriplaney on 08.05.22.
//

import Foundation

// MARK: - Person
struct Person: Codable {
    let name, height, mass, hairColor: String
    let skinColor, eyeColor, birthYear, gender: String
    let homeworld: String
    let films, species, vehicles, starships: [String]
    let created, edited: String
    let url: String
}
