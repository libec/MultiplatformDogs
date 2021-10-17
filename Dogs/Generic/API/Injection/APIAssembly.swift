//
//  APIAssembly.swift
//  Dogs
//
//  Created by Libor Huspenina on 17.10.2021.
//

import Swinject
import SwinjectAutoregistration

final class APIAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(APIConfiguration.self, initializer: ProductionAPIConfiguration.init)
    }
}
