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

    public func fetch() {
        repository.fetch()
    }
}
