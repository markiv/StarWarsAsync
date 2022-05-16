# Star Wars Swift Concurrency Workshop
## App Builders 2022

## Start
- Empty SwiftUI project
## Stage 1
- Add a Person DTO and a basic async Data request.
## Stage 2
- Generalize Decodable get. 
- Rename Person.
## Stage 3
- Generalize Decodable get. Rename Person to "People" for consistency. 
- Fetch and display a *page* of people.
## Stage 4
- Add a Film placeholder view with async loading.
## Stage 5
- Add aggresive caching to request!
## Stage 6
- Introduce a people view model and fetch *all* pages.
## Stage 7
- Separate People List view.
## Stages 8, 9
- Add a People detail view.
## Stages 10, 11
- Add a Film detail view.
## Stage 12
- Experiment: Request films concurrently (pretending we always have 3) with `async let`.
## Stage 13
- Fetch all films *concurrently* with a `TaskGroup`.
## Stage 14
- *Generalize* fetching of any `Decodable` from a collection of URLs.
## Stage 15
- Add a `getAllPossible` generic function that tries to fetch as many URLs as possible.
## Stage 16
- Add an opening crawl view.
- Add mock JSON for people and film (for previews).

