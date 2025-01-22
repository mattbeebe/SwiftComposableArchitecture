//
//  AppFeature.swift
//  SwiftComposableArchitecture
//
//  Created by Matthew Beebe on 1/21/25.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct AppFeature {
    struct State: Equatable {
        var tab1 = CounterFeature.State()
        var tab2 = StarWarsFeature.State()
    }
    
    enum Action {
        case tab1(CounterFeature.Action)
        case tab2(StarWarsFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.tab1, action: \.tab1) {
            CounterFeature()
        }
        Scope(state: \.tab2, action: \.tab2) {
            StarWarsFeature()
        }
        Reduce { state, action in
            return .none
        }
    }
    
}

struct AppView: View {
    let store: StoreOf<AppFeature>
    
    var body: some View {
        TabView {
            CounterView(store: store.scope(state: \.tab1, action: \.tab1))
                .tabItem {
                    Text("Counter")
                }
            
            StarWarsFilmsView(store: store.scope(state: \.tab2, action: \.tab2))
                .tabItem {
                    Text("Star Wars Films")
                }
        }
    }
}

#Preview {
  AppView(
    store: Store(initialState: AppFeature.State()) {
      AppFeature()
    }
  )
}
