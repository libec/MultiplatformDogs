//
//  BreedResource.swift
//  Dogs
//
//  Created by Libor Huspenina on 17.10.2021.
//

import Combine

public protocol BreedsResource {
    func fetch() -> AnyPublisher<[Breed], Error>
}
