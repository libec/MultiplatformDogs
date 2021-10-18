//
//  BreedsAssembly.swift
//  Dogs
//
//  Created by Libor Huspenina on 17.10.2021.
//

import Swinject
import SwinjectAutoregistration

final class BreedsAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(BreedsViewController.self, initializer: BreedsViewController.make)
        container.autoregister(BreedsResource.self, initializer: BreedsRemoteResource.init)
        container.autoregister(BreedsRepository.self, initializer: BreedsLocalRepository.init)
            .inObjectScope(.container)
        container.autoregister(FetchBreedsUseCase.self, initializer: FetchBreedsUseCaseImpl.init)
        container.autoregister(QueryBreedsUseCase.self, initializer: QueryBreedsUseCaseImpl.init)
        container.autoregister(BreedsViewModel.self, initializer: BreedsViewModelImpl.init)
    }
}
