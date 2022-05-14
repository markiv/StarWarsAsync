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
        try await baseURL.appendingPathComponent("people").request().get()
    }

    static func people(id: Int) async throws -> People {
        try await baseURL.appendingPathComponent("people/\(id)").request().get()
    }

    static func film(id: Int) async throws -> Film {
        try await baseURL.appendingPathComponent("film/\(id)").request().get()
    }
}

extension URL {
    func request() -> URLRequest {
        var this = URLRequest(url: self)
        this.cachePolicy = .returnCacheDataElseLoad
        return this
    }
}

extension URLRequest {
    static let snakeCaseDecoder: JSONDecoder = {
        let this = JSONDecoder()
        this.keyDecodingStrategy = .convertFromSnakeCase
        return this
    }()

    func get<T: Decodable>(decoder: JSONDecoder = snakeCaseDecoder) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: self)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try decoder.decode(T.self, from: data)
    }
}
