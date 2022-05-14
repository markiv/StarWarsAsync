//
//  FilmDetail.swift
//  StarWarsAsync
//
//  Created by Vikram Kriplaney on 14.05.22.
//

import SwiftUI

struct FilmDetail: View {
    let film: Film

    var body: some View {
        List {
            DetailItem(label: "Episode", value: "\(film.episodeId)")
            DetailItem(label: "Director", value: film.director)
            DetailItem(label: "Producer", value: film.producer)
            DetailItem(label: "Release Date", value: film.releaseDate)
            DetailItem(label: "Characters", value: "\(film.characters.count)")
            DetailItem(label: "Species", value: "\(film.species.count)")
            DetailItem(label: "Vehicles", value: "\(film.vehicles.count)")
            // DetailItem(label: "Opening Crawl", value: film.openingCrawl)
        }
            .navigationTitle(film.title)
    }
}

struct FilmDetail_Previews: PreviewProvider {
    static var previews: some View {
        FilmDetail(film: Film(
            title: "A New Hope",
            created: "Created",
            director: "Spielberg",
            edited: "Edited",
            episodeId: 1,
            openingCrawl: "Sed ut perspiciatis unde omnis iste...",
            producer: "Producer",
            releaseDate: "Released",
            characters: [],
            planets: [],
            species: [],
            starships: [],
            vehicles: [],
            url: "://"
        ))
    }
}
