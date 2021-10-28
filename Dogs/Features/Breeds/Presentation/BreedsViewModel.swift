//
//  BreedsViewModel.swift
//  Dogs
//
//  Created by Libor Huspenina on 18.10.2021.
//

import Combine

public struct DisplayableBreeds {
    public let name: String
    public let selection: (() -> Void)
}

public struct BreedsViewModelOutput {
    public let displayableBreeds: [DisplayableBreeds]
}

public protocol BreedsViewModel {
    var output: AnyPublisher<BreedsViewModelOutput, Never> { get }
    func fetch()
}

public final class BreedsViewModelImpl: BreedsViewModel {

    private let fetchUseCase: FetchBreedsUseCase
    private let queryUseCase: QueryBreedsUseCase
    private let selectBreedUseCase: SelectBreedUseCase

    @Published private var outputProperty: BreedsViewModelOutput = .init(displayableBreeds: [])

    public var output: AnyPublisher<BreedsViewModelOutput, Never> {
        $outputProperty.eraseToAnyPublisher()
    }

    public init(
        fetchUseCase: FetchBreedsUseCase,
        queryUseCase: QueryBreedsUseCase,
        selectBreedUseCase: SelectBreedUseCase
    ) {
        self.fetchUseCase = fetchUseCase
        self.queryUseCase = queryUseCase
        self.selectBreedUseCase = selectBreedUseCase

        queryUseCase
            .query()
            .map { breeds in
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
            .assign(to: &$outputProperty)
    }

    public func fetch() {
        fetchUseCase.fetch()
    }
}
