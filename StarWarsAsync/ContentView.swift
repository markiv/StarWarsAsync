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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


