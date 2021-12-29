//
//  BreedsLocalRepositoryTests.swift
//  DogsTests
//
//  Created by Libor Huspenina on 18.10.2021.
//

import Combine
import XCTest
import Dogs

class BreedsLocalRepositoryTests: XCTestCase {

    func test_result_from_fetch_can_be_queried() {
        var subscriptions = Set<AnyCancellable>()
        let breedsResource = BreedsResourceStub()
        let sut = BreedsLocalRepository(breedsResource: breedsResource)
        let resourceBreeds = ["akita", "boxer", "chow"].map(Breed.init)

        let expectation = XCTestExpectation()

        sut.query.sink { breeds in
            XCTAssertEqual(breeds, resourceBreeds)
            expectation.fulfill()
        }
        .store(in: &subscriptions)
        breedsResource.subject.send(resourceBreeds)

        wait(for: [expectation], timeout: .leastNonzeroMagnitude)
    }

    func test_replaces_error_with_empty_array() {
        var subscriptions = Set<AnyCancellable>()
        let breedsResource = BreedsResourceStub()
        let sut = BreedsLocalRepository(breedsResource: breedsResource)

        let expectation = XCTestExpectation()

        sut.query.sink { breeds in
            XCTAssertEqual(breeds, [])
            expectation.fulfill()
        }
        .store(in: &subscriptions)
        breedsResource.subject.send(completion: .failure(TestError.error))

        wait(for: [expectation], timeout: .leastNonzeroMagnitude)
    }
}

class BreedsResourceSpy: BreedsResource {

    var fetchCalled = false

    func fetch() -> AnyPublisher<[Breed], Error> {
        fetchCalled = true
        return Empty().eraseToAnyPublisher()
    }
}

class BreedsResourceStub: BreedsResource {

    let subject = PassthroughSubject<[Breed], Error>()

    func fetch() -> AnyPublisher<[Breed], Error> {
        return subject.eraseToAnyPublisher()
    }
}
