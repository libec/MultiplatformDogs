//
//  BreedDetailViewModelTests.swift
//  DogsTests
//
//  Created by Libor Huspenina on 21.10.2021.
//

import Combine
import XCTest
import Dogs

class BreedsDetailViewModelTests: XCTestCase {

    func test_returns_displayable_dogs_formatted_from_use_case() {
        var subscriptions = Set<AnyCancellable>()

        let queryDogsUseCase = QueryDogsUseCaseStub()
        let sut = BreedDetailViewModelImpl(queryDogsUseCase: queryDogsUseCase)

        let breed = Breed(name: "ridgeback")
        let dogs = [
            Dog(breed: breed, imageUrl: "image1"),
            Dog(breed: breed, imageUrl: "image331"),
            Dog(breed: breed, imageUrl: "image901"),
            Dog(breed: breed, imageUrl: "image123"),
        ]
        queryDogsUseCase.subject.send(dogs)
        let expectation = XCTestExpectation()
        let expectedDisplayableDogs: [DisplayableDog] = [
            DisplayableDog(imageUrl: "image1"),
            DisplayableDog(imageUrl: "image331"),
            DisplayableDog(imageUrl: "image901"),
            DisplayableDog(imageUrl: "image123"),
        ]

        sut.output.sink { displayableDogs in
            XCTAssertEqual(displayableDogs, expectedDisplayableDogs)
            expectation.fulfill()
        }.store(in: &subscriptions)

        wait(for: [expectation], timeout: .leastNormalMagnitude)
    }
}

class QueryDogsUseCaseStub: QueryDogsUseCase {

    let subject = CurrentValueSubject<[Dog], Never>([])

    func query() -> AnyPublisher<[Dog], Never> {
        subject.eraseToAnyPublisher()
    }
}
