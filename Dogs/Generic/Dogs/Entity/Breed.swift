//
//  Breed.swift
//  Dogs
//
//  Created by Libor Huspenina on 17.10.2021.
//

import Foundation

public struct Breed: Equatable {
    public let identifier: ID
    public let name: String

    public init(identifier: ID = UUID().uuidString, name: String) {
        self.identifier = identifier
        self.name = name
    }
}
