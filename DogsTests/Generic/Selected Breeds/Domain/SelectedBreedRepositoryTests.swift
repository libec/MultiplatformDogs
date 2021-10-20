//
//  SelectedBreedRepositoryTests.swift
//  DogsTests
//
//  Created by Libor Huspenina on 20.10.2021.
//

import Dogs
import XCTest
import Combine

final class SelectedBreedsRepositoryTests: XCTestCase {

    func test_when_selects_breed_then_notifies_about_it() {
        var subscriptions = Set<AnyCancellable>()

        let sut = InMemorySelectedBreedRepository()
        let selectedBreed = Breed(name: "pitbull")

        let expectation = XCTestExpectation()
        sut.select(breed: selectedBreed)

        sut.selectedBreed
            .sink { breed in
                XCTAssertEqual(selectedBreed, breed)
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: .leastNormalMagnitude)
    }

    func test_given_some_breed_selected_when_deselect_then_notifies_with_nil() {
        var subscriptions = Set<AnyCancellable>()

        let sut = InMemorySelectedBreedRepository()
        let selectedBreed = Breed(name: "pitbull")

        let expectation = XCTestExpectation()
        sut.select(breed: selectedBreed)
        sut.deselect()

        sut.selectedBreed
            .sink { breed in
                XCTAssertNil(breed)
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: .leastNormalMagnitude)
    }
}
