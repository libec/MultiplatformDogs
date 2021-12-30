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

    func test_selection_uses_repository_to_find_breed() {
        let selectedBreedRepository = SelectedBreedRepositorySpy()
        let breedsRepository = BreedsRepositoryStub()
        let repositoryBreeds = [
            Breed(identifier: "dog1", name: "Dog1"),
            Breed(identifier: "dog3", name: "Punta"),
            Breed(identifier: "dog5", name: "Laika")
        ]
        breedsRepository.lastToReturn = repositoryBreeds
        let sut = SelectBreedUseCaseImpl(
            selectedBreedRepository: selectedBreedRepository,
            breedsRepository: breedsRepository
        )

        sut.select(breedID: "dog5")

        XCTAssertEqual(selectedBreedRepository.inputSelectedBreed, Breed(identifier: "dog5", name: "Laika"))
    }
}
