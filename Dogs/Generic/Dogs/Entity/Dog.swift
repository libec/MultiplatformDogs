//
//  Dog.swift
//  Dogs
//
//  Created by Libor Huspenina on 17.10.2021.
//

import Foundation

public struct Dog: Equatable {
    public let identifier: ID
    public let imageUrl: String

    public init(identifier: ID = UUID().uuidString, imageUrl: String) {
        self.identifier = identifier
        self.imageUrl = imageUrl
    }
}
