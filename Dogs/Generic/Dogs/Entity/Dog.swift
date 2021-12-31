//
//  Dog.swift
//  Dogs
//
//  Created by Libor Huspenina on 17.10.2021.
//

import Foundation

public struct Dog: Equatable {
    public let imageUrl: String

    public init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
}
