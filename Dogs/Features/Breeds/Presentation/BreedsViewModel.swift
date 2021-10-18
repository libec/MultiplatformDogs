//
//  BreedsViewModel.swift
//  Dogs
//
//  Created by Libor Huspenina on 18.10.2021.
//

import Combine
import UIKit

public struct BreedsViewModelOutput {
    public let breedNames: [String]
}

public protocol BreedsViewModel {
    var output: AnyPublisher<BreedsViewModelOutput, Never> { get }
    func fetch()
}

public final class BreedsViewModelImpl: BreedsViewModel {

    private let fetchUseCase: FetchBreedsUseCase
    private let queryUseCase: QueryBreedsUseCase

    @Published private var outputProperty: BreedsViewModelOutput = .init(breedNames: [])

    public var output: AnyPublisher<BreedsViewModelOutput, Never> {
        $outputProperty.eraseToAnyPublisher()
    }

    public init(fetchUseCase: FetchBreedsUseCase, queryUseCase: QueryBreedsUseCase) {
        self.fetchUseCase = fetchUseCase
        self.queryUseCase = queryUseCase

        queryUseCase
            .query()
            .map { breeds in
                BreedsViewModelOutput(breedNames: breeds.map(\.name.capitalized))
            }
            .assign(to: &$outputProperty)
    }

    public func fetch() {
        fetchUseCase.fetch()
    }
}
