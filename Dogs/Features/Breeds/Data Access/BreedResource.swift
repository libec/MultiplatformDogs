//
//  BreedResource.swift
//  Dogs
//
//  Created by Libor Huspenina on 17.10.2021.
//

import Combine

public protocol BreedResource {
    func fetch() -> AnyPublisher<[Breed], Error>
}
