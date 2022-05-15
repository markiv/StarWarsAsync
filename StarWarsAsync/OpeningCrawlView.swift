//
//  OpeningCrawlView.swift
//  StarWarsAsync
//
//  Created by Vikram Kriplaney on 15.05.22.
//

import SwiftUI

struct OpeningCrawlView: View {
    let film: Film

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                Spacer(minLength: 200)
                Text("Episode \(film.episodeId)")
                Text(film.title)
                Text(film.openingCrawl)
                Spacer(minLength: 400)
            }
            .multilineTextAlignment(.center)
            .font(.title.bold())
            .foregroundColor(.yellow)
            .padding(.horizontal)
        }
        .rotation3DEffect(.degrees(45), axis: (x: 1, y: 0, z: 0), perspective: 0.5)
        .scaleEffect(y: 1.8)
        .background(.black)
    }
}

struct OpeningCrawlView_Previews: PreviewProvider {
    static var previews: some View {
        let film = Film.mock(name: "film1")
        OpeningCrawlView(film: film)
    }
}
