//
//  StarWarsAPI.swift
//  StarWarsAsync
//
//  Created by Vikram Kriplaney on 08.05.22.
//

import Fondue
import Foundation
import UIKit

enum StarWarsAPI {
    static let baseURL: URL = "https://swapi.dev/api/"

    static func peoplePage(from url: URL? = nil) async throws -> PeoplePage {
        let url = url ?? baseURL.appendingPathComponent("people")
        return try await url.request().make()
    }

    static func people(id: Int) async throws -> People {
        try await baseURL.appendingPathComponent("people/\(id)").request().make()
    }

    static func film(id: Int) async throws -> Film {
        try await baseURL.appendingPathComponent("film/\(id)").request().make()
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

    /// Makes (performs) this request.
    func make<T: Decodable>(decoder: JSONDecoder = snakeCaseDecoder) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: self)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
            throw URLError(.badServerResponse)
        }
        // try? await Task.sleep(nanoseconds: .random(in: 1_000_000_000...2_000_000_000))
        return try decoder.decode(T.self, from: data)
    }
}

extension Collection where Element == URL {
    /// Concurrently gets a collection of a generic Decodable type from a collection of URLs.
    /// This version will fail if any sub-task fails.
    func getAll<T: Decodable>() async throws -> [T] {
        var results = [T]()
        try await withThrowingTaskGroup(of: T.self) { group in
            forEach { url in
                group.addTask {
                    async let value: T = url.request().make()
                    return try await value
                }
            }
            for try await value in group {
                results.append(value)
            }
        }
        return results
    }

    /// Concurrently gets a collection of a generic Decodable type from a collection of URLs.
    /// This version will ignore any failures, returning as many elements as possible.
    func getAllPossible<T: Decodable>() async -> [T] {
        var results = [T]()
        await withTaskGroup(of: T?.self) { group in
            forEach { url in
                group.addTask {
                    async let value: T? = url.request().make()
                    return try? await value
                }
            }
            for await value in group {
                if let value = value {
                    results.append(value)
                }
            }
        }
        return results
    }
}
