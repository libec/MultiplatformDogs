//
//  QueryBreedsUseCAse.swift
//  Dogs
//
//  Created by Libor Huspenina on 18.10.2021.
//

import Combine

public protocol QueryBreedsUseCase {
    func query() -> AnyPublisher<[Breed], Never>
}

public final class QueryBreedsUseCaseImpl: QueryBreedsUseCase {

    private let repository: BreedsRepository

    public init(repository: BreedsRepository) {
        self.repository = repository
    }

    // NOTE: This is a function on purpose (not computed property), it's simple in this case but often times
    // it makes sense to use some kind of input to filter repository data.
    // This is the Query part of CQRS principle used on domain
    public func query() -> AnyPublisher<[Breed], Never> {
        repository.query
    }
}
