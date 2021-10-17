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
    }
}
