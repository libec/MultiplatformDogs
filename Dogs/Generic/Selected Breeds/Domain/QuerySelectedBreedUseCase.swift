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

    private let selectedBreedRepository: SelectedBreedRepository

    public init(selectedBreedRepository: SelectedBreedRepository) {
        self.selectedBreedRepository = selectedBreedRepository
    }

    public func selectedBreed() -> AnyPublisher<Breed?, Never> {
        selectedBreedRepository.selectedBreed
    }
}
