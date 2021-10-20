//
//  SelectBreedUseCase.swift
//  Dogs
//
//  Created by Libor Huspenina on 20.10.2021.
//

public protocol SelectBreedUseCase {
    func select(breed: Breed)
}

public final class SelectBreedUseCaseImpl: SelectBreedUseCase {

    private let selectedBreedRepository: SelectedBreedRepository

    public init(selectedBreedRepository: SelectedBreedRepository) {
        self.selectedBreedRepository = selectedBreedRepository
    }
    
    public func select(breed: Breed) {
        selectedBreedRepository.select(breed: breed)
    }
}

