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
}

import SwiftUI

extension URL {
    func get<T: Decodable>() async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: self)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

extension Decodable {
    static func state(from url: URL) async -> State<Self?> {
        let value: Self? = try? await url.get()
        return State(initialValue: value)
    }
}
