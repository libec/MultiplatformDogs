//
//  SelectedBreedsAssembly.swift
//  Dogs
//
//  Created by Libor Huspenina on 20.10.2021.
//

import Swinject
import SwinjectAutoregistration

final class SelectedBreedsAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(QuerySelectedBreedUseCase.self, initializer: QuerySelectedBreedUseCaseImpl.init)
    }
}
