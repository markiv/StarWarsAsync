//
//  PeopleDetail.swift
//  StarWarsAsync
//
//  Created by Vikram Kriplaney on 14.05.22.
//

import Fondue
import SwiftUI

struct PeopleDetail: View {
    let people: People

    var body: some View {
        List {
            Section {
                item(label: "Gender", value: people.gender)
                item(label: "Mass", value: people.mass)
                item(label: "Birth Year", value: people.birthYear)
                item(label: "Eye Color", value: people.eyeColor)
                item(label: "Skin Color", value: people.skinColor)
            }
            // item(label: "Home World", value: people.homeworld.absoluteString)
            // item(label: "Species", value: "\(people.species.count)")
            // item(label: "Vehicles", value: "\(people.vehicles.count)")
            Section("Films") {
                ForEach(people.films, id: \.self) { url in
                    FilmPlaceholder(url: url)
                }
            }
        }
        .navigationTitle(people.name)
    }

    @ViewBuilder func item(label: LocalizedStringKey, value: String?) -> some View {
        if let value = value {
            HStack {
                Text(label)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(value)
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
        } else if let error = error {
            Text(error.localizedDescription)
        } else {
            ProgressView("Loading...")
                .task {
                    do {
                        film = try await url.request().make()
                    } catch {
                        print(error)
                    }
                }
        }
    }
}

struct PeopleDetail_Previews: PreviewProvider {
    static var previews: some View {
        PeopleDetail(people: People(
            name: "Sample Skywalker",
            height: "1",
            mass: "1",
            hairColor: "Blond",
            skinColor: "White",
            eyeColor: "Green",
            birthYear: "1",
            gender: "Male",
            homeworld: "://",
            films: [],
            species: [],
            vehicles: [],
            starships: [],
            created: "",
            edited: "",
            url: "://"
        ))
    }
}
