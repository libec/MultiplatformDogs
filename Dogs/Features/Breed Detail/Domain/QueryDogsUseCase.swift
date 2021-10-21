//
//  QueryDogsUseCase.swift
//  Dogs
//
//  Created by Libor Huspenina on 21.10.2021.
//

import Combine

public protocol QueryDogsUseCase {
    func query() -> AnyPublisher<[Dog], Never>
}

public final class QueryDogsUseCaseImpl: QueryDogsUseCase {

    private let selectedBreedUseCase: QuerySelectedBreedUseCase

    // NOTE: - this demonstrates that you don't always need to use repository
    // if it makes sense to just load the data and not share them anywhere
    private let breedDetailResource: BreedDetailResource

    public init(selectedBreedUseCase: QuerySelectedBreedUseCase, breedDetailResource: BreedDetailResource) {
        self.selectedBreedUseCase = selectedBreedUseCase
        self.breedDetailResource = breedDetailResource
    }

    public func query() -> AnyPublisher<[Dog], Never> {
        selectedBreedUseCase.selectedBreed()
            .flatMap { [weak self] breed -> AnyPublisher<[Dog], Never> in
                guard let unwrappedSelf = self else { return [].publisher.eraseToAnyPublisher() }
                if let breed = breed {
                    return unwrappedSelf.breedDetailResource
                        .query(breed: breed)
                        .replaceError(with: [])
                        .eraseToAnyPublisher()
                } else {
                    return [].publisher.eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
