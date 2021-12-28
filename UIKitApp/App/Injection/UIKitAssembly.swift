import Swinject
import SwinjectAutoregistration
import Dogs
import UIKit

class UIKitAppAssembly: Assembly {
    func assemble(container: Container) {

        container.autoregister(BreedsDetailViewController.self, initializer: BreedsDetailViewController.make)

        container.autoregister(BreedsViewController.self, initializer: BreedsViewController.make)

        container.autoregister(Coordinator.self, initializer: UIKitCoordinator.init)
            .inObjectScope(.container)

        container.register(UIWindow.self) { _ in
            UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }!
        }
    }

    func loaded(resolver: Resolver) {
        _ = resolver.resolve(Coordinator.self)
    }
}
