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
    let homeworld: URL
    let films, species, vehicles, starships: [URL]
    let created, edited: String
    let url: URL
}

struct PeoplePage: Decodable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [People]
}

struct Film: Codable {
    let title: String
    let created, director, edited: String
    let episodeId: Int
    let openingCrawl: String
    let producer, releaseDate: String
    let characters: [URL]
    let planets: [URL]
    let species, starships: [URL]
    let vehicles: [URL]
    let url: URL
}
