//
//  CounterFeatureTests.swift
//  SwiftComposableArchitectureTests
//
//  Created by Matthew Beebe on 1/19/25.
//

import ComposableArchitecture
import Testing

@testable import SwiftComposableArchitecture

@MainActor
struct CounterFeatureTests {
    @Test
    func basicsCount() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await store.send(.incrementButtonTapped) {
            // indicate mutated state to equal state after action
            $0.count = 1
        }
        await store.send(.decrementButtonTapped) {
            // indicate mutated state to equal state after action
            $0.count = 0
        }
    }
    
    @Test
    func basicsTimerTick() async {
        let clock = TestClock()
        
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        await clock.advance(by: .seconds(1))
        await store.receive(\.timerTick) {
            $0.count = 1
        }
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
    }
    
    @Test
    func numberFact() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.numberFact.fetch = { "\($0) is a good number." }
        }
        
        await store.send(.factButtonTapped) {
            $0.isLoading = true
        }
        await store.receive(\.factResponse) {
            $0.isLoading = false
            $0.fact = "0 is a good number."
        }
    }
}
