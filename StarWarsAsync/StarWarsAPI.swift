//
//  StarWarsAPI.swift
//  StarWarsAsync
//
//  Created by Vikram Kriplaney on 08.05.22.
//

import Foundation

enum StarWarsAPI {
    static let baseURL = URL(string: "https://swapi.dev/api/")!

    static func peoplePage(from url: URL? = nil) async throws -> PeoplePage {
        let url = url ?? baseURL.appendingPathComponent("people")
        return try await url.request().get()
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
        modified(URLRequest(url: self)) {
            $0.cachePolicy = .returnCacheDataElseLoad
        }
    }
}

extension URLRequest {
    static let snakeCaseDecoder = modified(JSONDecoder()) {
        $0.keyDecodingStrategy = .convertFromSnakeCase
    }

    func get<T: Decodable>(decoder: JSONDecoder = snakeCaseDecoder) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: self)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
            throw URLError(.badServerResponse)
        }
        // try? await Task.sleep(nanoseconds: .random(in: 1_000_000_000...2_000_000_000))
        return try decoder.decode(T.self, from: data)
    }
}

func modified<T>(_ t: T, modifier: (inout T) -> Void) -> T {
    var t = t
    modifier(&t)
    return t
}
