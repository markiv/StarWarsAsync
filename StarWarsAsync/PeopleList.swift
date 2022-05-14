//
//  PeopleList.swift
//  StarWarsAsync
//
//  Created by Vikram Kriplaney on 14.05.22.
//

import SwiftUI

struct PeopleList: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        List(viewModel.people, id: \.url) { people in
            NavigationLink(people.name) {
                PeopleDetail(people: people)
            }
        }
        .navigationTitle("People")

        .task {
            do {
                try await viewModel.fetchAllPages()
            } catch {
                print(error)
            }
        }
    }
}

extension PeopleList {
    class ViewModel: ObservableObject {
        @Published var people = [People]()

        @MainActor func fetchAllPages() async throws {
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
}

struct PeopleList_Previews: PreviewProvider {
    static var previews: some View {
        PeopleList()
    }
}
