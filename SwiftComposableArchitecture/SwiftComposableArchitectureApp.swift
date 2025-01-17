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
    // should only be created once
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
    }
    var body: some Scene {
        WindowGroup {
            CounterView(
                store: SwiftComposableArchitectureApp.store
            )
        }
    }
}
