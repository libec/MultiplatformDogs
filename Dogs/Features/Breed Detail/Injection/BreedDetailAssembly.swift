//
//  BreedDetailAssembly.swift
//  Dogs
//
//  Created by Libor Huspenina on 20.10.2021.
//

import Swinject
import SwinjectAutoregistration

final class BreedDetailAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(BreedDetailViewModel.self, initializer: BreedDetailViewModelImpl.init)
        container.autoregister(QueryDogsUseCase.self, initializer: QueryDogsUseCaseImpl.init)
        container.autoregister(BreedDetailResource.self, initializer: BreedDetailRemoteResource.init)
    }
}
