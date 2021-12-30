//
//  SelectBreedUseCase.swift
//  Dogs
//
//  Created by Libor Huspenina on 20.10.2021.
//

import Foundation

public protocol SelectBreedUseCase {
    func select(breedID: ID)
}

public final class SelectBreedUseCaseImpl: SelectBreedUseCase {

    private let selectedBreedRepository: SelectedBreedRepository
    private let breedsRepository: BreedsRepository

    public init(
        selectedBreedRepository: SelectedBreedRepository,
        breedsRepository: BreedsRepository
    ) {
        self.selectedBreedRepository = selectedBreedRepository
        self.breedsRepository = breedsRepository
    }
    
    public func select(breedID: ID) {
        if let breed = breedsRepository.last.first(where: { breed in breed.identifier == breedID }) {
            selectedBreedRepository.select(breed: breed)
        }
    }
}
