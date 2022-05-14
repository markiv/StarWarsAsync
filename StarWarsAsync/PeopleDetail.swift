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
                DetailItem(label: "Gender", value: people.gender)
                DetailItem(label: "Mass", value: people.mass)
                DetailItem(label: "Birth Year", value: people.birthYear)
                DetailItem(label: "Eye Color", value: people.eyeColor)
                DetailItem(label: "Skin Color", value: people.skinColor)
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
}

struct DetailItem: View {
    let label: LocalizedStringKey
    let value: String?

    var body: some View {
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
            NavigationLink(film.title) {
                FilmDetail(film: film)
            }            
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
