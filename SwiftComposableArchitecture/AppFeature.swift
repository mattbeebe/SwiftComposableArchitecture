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
        var tab3 = ContactsFeature.State(
            contacts: [
                Contact(id: UUID(), name: "Blob"),
                Contact(id: UUID(), name: "Blob Jr"),
                Contact(id: UUID(), name: "Blob Sr")
            ])
    }
    
    enum Action {
        case tab1(CounterFeature.Action)
        case tab2(StarWarsFeature.Action)
        case tab3(ContactsFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.tab1, action: \.tab1) {
            CounterFeature()
        }
        Scope(state: \.tab2, action: \.tab2) {
            StarWarsFeature()
        }
        Scope(state: \.tab3, action: \.tab3) {
            ContactsFeature()
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
            
            ContactsView(store: store.scope(state: \.tab3, action: \.tab3))
                .tabItem {
                    Text("Contacts Feature")
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
