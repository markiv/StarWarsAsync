//
//  DTOs.swift
//  StarWarsAsync
//
//  Created by Vikram Kriplaney on 08.05.22.
//

import Foundation

struct People: Decodable {
    let name: String
    let height, mass, hairColor: String?
    let skinColor, eyeColor, birthYear, gender: String?
    let homeworld: String
    let films, species, vehicles, starships: [String]
    let created, edited: String
    let url: String
}

struct PeopleResults: Decodable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [People]
}
