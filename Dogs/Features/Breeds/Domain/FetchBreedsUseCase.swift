//
//  FetchBreedsUseCase.swift
//  Dogs
//
//  Created by Libor Huspenina on 18.10.2021.
//

public protocol FetchBreedsUseCase {
    func fetch()
}

public final class FetchBreedsUseCaseImpl: FetchBreedsUseCase {

    private let repository: BreedsRepository

    public init(repository: BreedsRepository) {
        self.repository = repository
    }

    // This is the Command part of CQRS principle used on domain
    // it's also simple in this case but imagine it being operation which
    // changes data somehow
    public func fetch() {
        repository.fetch()
    }
}
