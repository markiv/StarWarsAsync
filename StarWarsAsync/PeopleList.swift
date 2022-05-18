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
        @MainActor @Published var people = [People]()

        nonisolated func fetchAllPages() async throws {
            await MainActor.run {
                people = []
            }
            var next: URL?
            var count = 0
            while true {
                let page = try await StarWarsAPI.peoplePage(from: next)
                await MainActor.run {
                    people.append(contentsOf: page.results)
                }
                count += page.results.count
                next = page.next
                guard next != nil, count < page.count else { break }
            }
        }
    }
}

struct PeopleList_Previews: PreviewProvider {
    static var previews: some View {
        PeopleList()
    }
}
