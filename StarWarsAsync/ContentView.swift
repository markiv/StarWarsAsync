//
//  ContentView.swift
//  StarWarsAsync
//
//  Created by Vikram Kriplaney on 08.05.22.
//

import SwiftUI

struct ContentView: View {
    @State private var results: PeopleResults?

    var body: some View {
        List(results?.results ?? [], id: \.url) { people in
            Text(people.name)
            ForEach(people.films, id: \.self) {
                FilmPlaceholder(url: $0)
            }
        }
        .task {
            do {
                results = try await StarWarsAPI.people()
            } catch {
                print(error)
            }
        }
    }
}

struct FilmPlaceholder: View {
    let url: URL
    @State private var film: Film?
    @State private var error: Error?

    var body: some View {
        if let film = film {
            Text(film.title)
            Text(film.director)
            Text(film.producer)
        } else if let error = error {
            Text(error.localizedDescription)
        } else {
            ProgressView("Loading...")
                .task {
                    do {
                        film = try await url.get()
                    } catch {
                        print(error)
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
