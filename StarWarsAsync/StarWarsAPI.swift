//
//  StarWarsAPI.swift
//  StarWarsAsync
//
//  Created by Vikram Kriplaney on 08.05.22.
//

import Foundation

enum StarWarsAPI {
    static let baseURL = URL(string: "https://swapi.dev/api/")!

    static func people() async throws -> PeopleResults {
        try await baseURL.appendingPathComponent("people").get()
    }

    static func people(id: Int) async throws -> People {
        try await baseURL.appendingPathComponent("people/\(id)").get()
    }

    static func film(id: Int) async throws -> Film {
        try await baseURL.appendingPathComponent("film/\(id)").get()
    }
}

extension URL {
    static let snakeCaseDecoder: JSONDecoder = {
        let this = JSONDecoder()
        this.keyDecodingStrategy = .convertFromSnakeCase
        return this
    }()

    func get<T: Decodable>(decoder: JSONDecoder = snakeCaseDecoder) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: self)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try decoder.decode(T.self, from: data)
    }
}
