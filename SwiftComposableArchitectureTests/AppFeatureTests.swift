//
//  AppFeatureTests.swift
//  SwiftComposableArchitectureTests
//
//  Created by Matthew Beebe on 1/21/25.
//

import ComposableArchitecture
import Testing

@testable import SwiftComposableArchitecture

@MainActor
struct AppFeatureTests {
    @Test
    func incrementInFirstTab() async {
        let store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }
        
        await store.send(\.tab1.incrementButtonTapped) {
            $0.tab1.count = 1
        }
    }
}
