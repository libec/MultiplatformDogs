//
//  QuerySelectedBreedUseCAse.swift
//  Dogs
//
//  Created by Libor Huspenina on 20.10.2021.
//

import Combine

public protocol QuerySelectedBreedUseCase {
    func selectedBreed() -> AnyPublisher<Breed?, Never>
}

public final class QuerySelectedBreedUseCaseImpl: QuerySelectedBreedUseCase {

    public init() { }

    public func selectedBreed() -> AnyPublisher<Breed?, Never> {
        Empty().eraseToAnyPublisher()
    }
}
