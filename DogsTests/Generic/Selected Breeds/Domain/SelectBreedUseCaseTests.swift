//
//  SelectBreedUseCaseTests.swift
//  DogsTests
//
//  Created by Libor Huspenina on 20.10.2021.
//

import Dogs
import XCTest
import Combine

final class SelectBreedUseCaseTests: XCTestCase {

    func test_when_select_then_passes_breed_to_repository() {
        let selectedBreedRepository = SelectedBreedRepositorySpy()
        let sut = SelectBreedUseCaseImpl(selectedBreedRepository: selectedBreedRepository)

        let breedToSelect = Breed(name: "chihuahua")
        sut.select(breed: breedToSelect)

        XCTAssertEqual(selectedBreedRepository.inputSelectedBreed, breedToSelect)
    }
}
