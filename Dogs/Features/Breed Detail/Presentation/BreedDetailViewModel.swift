//
//  BreedDetailViewModel.swift
//  Dogs
//
//  Created by Libor Huspenina on 21.10.2021.
//

import Combine
import Foundation

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

    public var output: AnyPublisher<[DisplayableDog], Never> {
        queryDogsUseCase.query()
            .map { dogs in
                dogs.map { dog in
                    DisplayableDog(imageUrl: dog.imageUrl)
                }
            }
            .receive(on: DispatchQueue.main, options: .none)
            .eraseToAnyPublisher()
    }

    public init(queryDogsUseCase: QueryDogsUseCase) {
        self.queryDogsUseCase = queryDogsUseCase
    }
}
