//
//  QuerySelectedBreedUseCaseTests.swift
//  DogsTests
//
//  Created by Libor Huspenina on 20.10.2021.
//

import Dogs
import XCTest
import Combine

final class QuerySelectedBreedUseCaseTests: XCTestCase {

    func test_when_repository_notifies_then_sut_notifies() {
        var subscriptions = Set<AnyCancellable>()
        let selectedBreedRepository = SelectedBreedRepositoryStub()
        let sut = QuerySelectedBreedUseCaseImpl(selectedBreedRepository: selectedBreedRepository)
        let repositoryBreed = Breed(name: "Golder retriever")

        selectedBreedRepository.subject.send(repositoryBreed)

        let expectation = XCTestExpectation()
        sut.selectedBreed()
            .sink(receiveValue: { breed in
                XCTAssertEqual(breed, repositoryBreed)
                expectation.fulfill()
            })
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: .leastNormalMagnitude)
    }
}
