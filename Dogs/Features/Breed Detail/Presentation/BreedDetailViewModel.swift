//
//  BreedDetailViewModel.swift
//  Dogs
//
//  Created by Libor Huspenina on 21.10.2021.
//

import Combine

public struct DisplayableDog: Equatable {
    public let imageUrl: String

    public init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
}

public protocol BreedDetailViewModel {
    var output: AnyPublisher<[DisplayableDog], Never> { get }
}

public final class BreedDetailViewModelImpl: BreedDetailViewModel {

    private let queryDogsUseCase: QueryDogsUseCase

    @Published private var outputProperty: [DisplayableDog] = []

    public var output: AnyPublisher<[DisplayableDog], Never> {
        $outputProperty.eraseToAnyPublisher()
    }

    public init(queryDogsUseCase: QueryDogsUseCase) {
        self.queryDogsUseCase = queryDogsUseCase

        queryDogsUseCase.query()
            .map { dogs in
                dogs.map { dog in
                    DisplayableDog(imageUrl: dog.imageUrl)
                }
            }
            .assign(to: &$outputProperty)
    }
}
