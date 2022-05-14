//
//  ContentView.swift
//  StarWarsAsync
//
//  Created by Vikram Kriplaney on 08.05.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PeopleViewModel()

    var body: some View {
        List(viewModel.people, id: \.url) { people in
            Text(people.name)
//            ForEach(people.films, id: \.self) {
//                FilmPlaceholder(url: $0)
//            }
        }
        .task {
            do {
                try await viewModel.fetchAll()
            } catch {
                print(error)
            }
        }
    }
}

@MainActor class PeopleViewModel: ObservableObject {
    @Published var people = [People]()

    func fetchAll() async throws {
        people = []
        var url: URL?
        while true {
            let page = try await StarWarsAPI.peoplePage(from: url)
            people.append(contentsOf: page.results)
            guard let next = page.next, people.count < page.count else { break }
            url = next
        }
    }
}

struct FilmPlaceholder: View {
    let url: URL
    @State private var film: Film?
    @State private var error: Error?

    var body: some View {
        if let film = film {
            VStack(alignment: .leading) {
                Text(film.title)
                Text(film.director)
                Text(film.producer)
            }
            .padding(.leading)
        } else if let error = error {
            Text(error.localizedDescription)
        } else {
            ProgressView("Loading...")
                .task {
                    do {
                        film = try await url.request().get()
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
