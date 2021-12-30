//
//  QueryBreedsUseCaseTests.swift
//  DogsTests
//
//  Created by Libor Huspenina on 18.10.2021.
//

import XCTest
import Combine
import Dogs

class QueryBreedsUseCaseTests: XCTestCase {

    func test_when_repository_then_query_triggers() {
        var subscriptions = Set<AnyCancellable>()
        let repository = BreedsRepositoryStub()
        let sut = QueryBreedsUseCaseImpl(repository: repository)

        let expectation = XCTestExpectation()
        let repositoryBreeds = ["corgi", "dane"].map { Breed(name: $0) }

        sut.query()
            .sink { breeds in
                XCTAssertEqual(breeds, repositoryBreeds)
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        repository.subject.send(repositoryBreeds)

        wait(for: [expectation], timeout: .leastNormalMagnitude)
    }
}
