//
//  BreedsViewModel.swift
//  Dogs
//
//  Created by Libor Huspenina on 18.10.2021.
//

import Combine
import Foundation

public struct DisplayableBreeds {
    public let name: String
    public let selection: (() -> Void)

    public init(name: String, selection: @escaping (() -> Void)) {
        self.name = name
        self.selection = selection
    }
}

public struct BreedsViewModelOutput {

    public let displayableBreeds: [DisplayableBreeds]

    public init(displayableBreeds: [DisplayableBreeds]) {
        self.displayableBreeds = displayableBreeds
    }
}

public protocol BreedsViewModel {
    var output: AnyPublisher<BreedsViewModelOutput, Never> { get }
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
                    DisplayableBreeds(name: breed.name.capitalized) { [weak self] () -> Void in
                        guard let unwrappedSelf = self else { return }
                        unwrappedSelf.selectBreedUseCase.select(breed: breed)
                    }
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
}
