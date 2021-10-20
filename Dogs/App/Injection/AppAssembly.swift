//
//  AppAssembly.swift
//  Dogs
//
//  Created by Libor Huspenina on 20.10.2021.
//

import Swinject
import SwinjectAutoregistration
import UIKit

final class AppAssembly: Assembly {
    func assemble(container: Container) {
        container.register(UIWindow.self) { _ in
            UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }!
        }
    }
}
