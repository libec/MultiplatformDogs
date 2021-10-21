//
//  QueryDogsUseCaseTests.swift
//  DogsTests
//
//  Created by Libor Huspenina on 21.10.2021.
//

import XCTest
import Combine
import Dogs

class QueryDogsUseCaseTests: XCTestCase {

    func test_uses_breed_to_trigger_resource() {
        var subscriptions = Set<AnyCancellable>()

        let selectedBreedUseCase = QuerySelectedBreedUseCaseStub()
        let breedDetailResource = BreedDetailResourceSpy()
        let sut = QueryDogsUseCaseImpl(
            selectedBreedUseCase: selectedBreedUseCase,
            breedDetailResource: breedDetailResource
        )

        selectedBreedUseCase.subject.send(Breed(name: "pitbull"))
        sut.query().sink(receiveValue: { _ in }).store(in: &subscriptions)

        XCTAssertEqual(breedDetailResource.queryBreed, Breed(name: "pitbull"))
    }

    func test_returns_dogs_from_resource() {
        var subscriptions = Set<AnyCancellable>()
        let selectedBreedUseCase = QuerySelectedBreedUseCaseStub()
        let breedDetailResource = BreedDetailResourceStub()
        let sut = QueryDogsUseCaseImpl(
            selectedBreedUseCase: selectedBreedUseCase,
            breedDetailResource: breedDetailResource
        )

        let breed = Breed(name: "pitbull")
        let dogs = [Dog(breed: breed, imageUrl: "Imageurl"), Dog(breed: breed, imageUrl: "http://image2")]
        selectedBreedUseCase.subject.send(breed)
        breedDetailResource.subject.send(dogs)

        let expectation = XCTestExpectation()

        sut.query()
            .sink { sutDogs in
                expectation.fulfill()
                XCTAssertEqual(dogs, sutDogs)
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: .leastNormalMagnitude)
    }
}

class BreedDetailResourceStub: BreedDetailResource {

    let subject = CurrentValueSubject<[Dog], Error>([])

    func query(breed: Breed) -> AnyPublisher<[Dog], Error> {
        return subject.eraseToAnyPublisher()
    }
}

class BreedDetailResourceSpy: BreedDetailResource {
    var queryBreed: Breed?

    func query(breed: Breed) -> AnyPublisher<[Dog], Error> {
        queryBreed = breed
        return Empty().eraseToAnyPublisher()
    }
}

class QuerySelectedBreedUseCaseStub: QuerySelectedBreedUseCase {

    let subject = CurrentValueSubject<Breed?, Never>(nil)

    func selectedBreed() -> AnyPublisher<Breed?, Never> {
        subject.eraseToAnyPublisher()
    }
}
