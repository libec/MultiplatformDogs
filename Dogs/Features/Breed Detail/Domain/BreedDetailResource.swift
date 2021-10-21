//
//  BreedDetailResource.swift
//  Dogs
//
//  Created by Libor Huspenina on 21.10.2021.
//

import Combine

public protocol BreedDetailResource {
    func query(breed: Breed) -> AnyPublisher<[Dog], Error>
}
