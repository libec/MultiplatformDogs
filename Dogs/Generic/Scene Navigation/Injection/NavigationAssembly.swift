//
//  NavigationAssembly.swift
//  Dogs
//
//  Created by Libor Huspenina on 20.10.2021.
//

import Swinject

class NavigationAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(Coordinator.self, initializer: UIKitCoordinator.init)
            .inObjectScope(.container)
    }

    func loaded(resolver: Resolver) {
        _ = resolver.resolve(Coordinator.self)
    }
}
