//
//  BreedsRepositoryMocks.swift
//  DogsTests
//
//  Created by Libor Huspenina on 18.10.2021.
//

import Dogs
import Combine

class BreedsRepositorySpy: BreedsRepository {

    var fetchCalled = false

    func fetch() {
        fetchCalled = true
    }

    var query: AnyPublisher<[Breed], Never> {
        Empty().eraseToAnyPublisher()
    }

    var last: [Breed] = []
}

class BreedsRepositoryStub: BreedsRepository {

    var subject = PassthroughSubject<[Breed], Never>()
    var lastToReturn: [Breed] = []

    func fetch() { }

    var query: AnyPublisher<[Breed], Never> {
        return subject.eraseToAnyPublisher()
    }

    var last: [Breed] {
        lastToReturn
    }
}
