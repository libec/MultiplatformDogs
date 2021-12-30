//
//  BreedDetailViewModel.swift
//  Dogs
//
//  Created by Libor Huspenina on 21.10.2021.
//

import Combine
import Foundation

public struct DisplayableDog: Equatable {

    public let dogId: ID
    public let imageUrl: String
    public let favorite: Bool

    public init(dogID: ID, imageUrl: String, favorite: Bool) {
        self.dogId = dogID
        self.imageUrl = imageUrl
        self.favorite = favorite
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
                    DisplayableDog(dogID: dog.identifier, imageUrl: dog.imageUrl, favorite: false)
                }
            }
            .eraseToAnyPublisher()
    }

    public init(queryDogsUseCase: QueryDogsUseCase) {
        self.queryDogsUseCase = queryDogsUseCase
    }
}
