//
//  AppStart.swift
//  Dogs
//
//  Created by Libor Huspenina on 17.10.2021.
//

import Foundation
import Swinject

public struct AppStart {

    private var appAssemblies: [Assembly] = [
        BreedsAssembly(),
        InstanceProviderAssembly(),
    ]

    public init() { }

    public func startApp<Instance>() -> Instance {
        let assembler = Assembler()
        assembler.apply(assemblies: appAssemblies)
        return assembler.resolver.resolve(Instance.self)!
    }
}
