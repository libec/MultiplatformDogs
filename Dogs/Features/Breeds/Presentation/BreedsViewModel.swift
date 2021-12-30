//
//  BreedsViewModel.swift
//  Dogs
//
//  Created by Libor Huspenina on 18.10.2021.
//

import Combine
import Foundation

public struct DisplayableBreed {
    public let identifier: ID
    public let name: String

    public init(identifier: ID, name: String) {
        self.name = name
        self.identifier = identifier
    }
}

public struct BreedsViewModelOutput {

    public let displayableBreeds: [DisplayableBreed]

    public init(displayableBreeds: [DisplayableBreed]) {
        self.displayableBreeds = displayableBreeds
    }
}

public protocol BreedsViewModel {
    var output: AnyPublisher<BreedsViewModelOutput, Never> { get }
    func select(breed: ID)
}

public final class BreedsViewModelImpl: BreedsViewModel {

    private let queryUseCase: QueryBreedsUseCase
    private let selectBreedUseCase: SelectBreedUseCase

    public var output: AnyPublisher<BreedsViewModelOutput, Never> {
        queryUseCase.query().map { breeds in
            BreedsViewModelOutput(
                displayableBreeds: breeds
                    .sorted(by: { lhs, rhs in
                        lhs.name < rhs.name
                    })
                    .map { breed in
                        DisplayableBreed(identifier: breed.identifier, name: breed.name.capitalized)
                }
            )
        }
        .eraseToAnyPublisher()
    }

    public init(
        queryUseCase: QueryBreedsUseCase,
        selectBreedUseCase: SelectBreedUseCase
    ) {
        self.queryUseCase = queryUseCase
        self.selectBreedUseCase = selectBreedUseCase
    }

    public func select(breed: ID) {
        selectBreedUseCase.select(breedID: breed)
    }
}
