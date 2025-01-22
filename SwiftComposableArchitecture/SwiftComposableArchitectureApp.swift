//
//  SwiftComposableArchitectureApp.swift
//  SwiftComposableArchitecture
//
//  Created by Matthew Beebe on 1/17/25.
//

import ComposableArchitecture
import SwiftUI

@main
struct SwiftComposableArchitectureApp: App {
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
    }
    
//    // should only be created once
//    static let store = Store(initialState: CounterFeature.State()) {
//        CounterFeature()
        
//    static let store = Store(initialState: StarWarsFeature.State()) {
//        StarWarsFeature()
//            ._printChanges()
//    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: SwiftComposableArchitectureApp.store)
            
//            CounterView(
//                store: SwiftComposableArchitectureApp.store
//            )
            
//            StarWarsFilmsView(store: SwiftComposableArchitectureApp.store)
        }
    }
}
