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
        container.autoregister(BreedsDetailViewController.self, initializer: BreedsDetailViewController.make)
    }
}
