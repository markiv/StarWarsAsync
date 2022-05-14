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
    @State private var films: [Film]?

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

            if let films = films, !films.isEmpty {
                Section("Films") {
                    ForEach(films, id: \.url) { film in
                        NavigationLink(film.title) {
                            FilmDetail(film: film)
                        }
                    }
                }
            }
        }
        .navigationTitle(people.name)
        .task {
            films = try? await people.films.getAll()
        }
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
