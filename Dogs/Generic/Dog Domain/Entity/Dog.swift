//
//  Dog.swift
//  Dogs
//
//  Created by Libor Huspenina on 17.10.2021.
//

public struct Dog: Equatable {
    public let breed: Breed
    public let imageUrl: String

    public init(breed: Breed, imageUrl: String) {
        self.breed = breed
        self.imageUrl = imageUrl
    }
}
