//
//  StarWarsAPI.swift
//  StarWarsAsync
//
//  Created by Vikram Kriplaney on 08.05.22.
//

import Foundation

enum StarWarsAPI {
    static let baseURL = URL(string: "https://swapi.dev/api/")!

    static func people(id: Int) async throws -> Data {
        try await URLSession.shared.data(from: baseURL).0
    }
}
