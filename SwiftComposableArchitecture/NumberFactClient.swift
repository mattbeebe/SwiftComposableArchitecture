//
//  NumberFactClient.swift
//  SwiftComposableArchitecture
//
//  Created by Matthew Beebe on 1/19/25.
//

import ComposableArchitecture
import Foundation

struct NumberFactClient {
    var fetch: (Int) async throws -> String
}

// register dependency with library
// conform to DependencyKey protocol
extension NumberFactClient: DependencyKey {
    // used by simulators and devices
    static let liveValue = Self(
        fetch: { number in
            let (data, _) = try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(number)")!)
            return String(decoding: data, as: UTF8.self)
        }
    )
}

// register dependency with library
// allows for .numberFact syntax for @Dependency(\.numberFact)
extension DependencyValues {
    var numberFact: NumberFactClient {
        get { self[NumberFactClient.self] }
        set { self[NumberFactClient.self] = newValue }
    }
}
