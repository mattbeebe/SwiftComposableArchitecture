//
//  StarWarsFilmsView.swift
//  SwiftComposableArchitecture
//
//  Created by Matthew Beebe on 1/17/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct StarWarsFeature {
    @ObservableState
    struct State: Equatable {
        var starWarsFilms: [Film] = []
        var filmNumber = 1
    }
    
    enum Action {
        case fetchStarWarsFilms
        case filmResponse(StarWarsFilmJson)
    }
    
    struct Film: Identifiable, Equatable {
        var id: String
        var title: String
    }
    
    struct StarWarsFilmJson: Decodable {
        var title: String
        var episode_id: Int
        var opening_crawl: String
        var director: String
        var producer: String
        var release_date: String
        var species: [String]
        var starships: [String]
        var vehicles: [String]
        var characters: [String]
        var planets: [String]
        var url: String
        var created: String
        var edited: String
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchStarWarsFilms:
                return .run { [filmNumber = state.filmNumber] send in
                    let (data, _) = try await URLSession.shared.data(from: URL(string: "https://swapi.dev/api/films/\(filmNumber)")!)
                    let filmJson = try JSONDecoder().decode(StarWarsFilmJson.self, from: data)
                    await send(.filmResponse(filmJson))
                }
            case .filmResponse(let film):
                state.starWarsFilms.append(Film(id: UUID().uuidString, title: film.title))
                state.filmNumber = state.filmNumber < 6 ? state.filmNumber + 1 : 1
                return .none
            }
        }
    }
}

struct StarWarsFilmsView: View {
    let store: StoreOf<StarWarsFeature>
    
    var body: some View {
        VStack {
            Text("Star Wars Films 🪐")
                .font(.largeTitle)
                .padding()
            if store.starWarsFilms.isEmpty {
                Text("Go on! Click that button ⬇️")
            } else {
                ScrollView {
                    ForEach (store.starWarsFilms) { film in
                        Text(film.title)
                    }
                }
            }
            Spacer()
            Button("Fetch Films") {
                store.send(.fetchStarWarsFilms)
            }
        }
        
    }
}

#Preview {
    StarWarsFilmsView(store: Store(initialState: StarWarsFeature.State()) {
        StarWarsFeature()
            ._printChanges()
    })
}
