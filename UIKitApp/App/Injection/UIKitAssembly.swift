import Swinject
import SwinjectAutoregistration
import Dogs
import UIKit

class UIKitAppAssembly: Assembly {
    func assemble(container: Container) {

        container.register(DogsViewController.self) { (resolver: Resolver, strategy: DogsDisplayStrategy) in
            return DogsViewController.make(
                viewModel: resolver.resolve(DogsViewModel.self, argument: strategy)!,
                dogCellFactory: resolver.resolve(DogCellFactory.self)!
            )
        }

        container.autoregister(BreedsViewController.self, initializer: BreedsViewController.make)

        container.autoregister(UIKitNavigation.self, initializer: UIKitNavigation.init)
            .inObjectScope(.container)

        container.register(UIWindow.self) { _ in
            UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }!
        }

        container.autoregister(DogCellFactory.self, initializer: DogCellFactoryImpl.init)

        container.register(RootViewController.self) { resolver in
            let breedsViewController = resolver.resolve(BreedsViewController.self)!
            let favoriteDogs = resolver.resolve(DogsViewController.self, argument: DogsDisplayStrategy.favorites)!
            return RootViewController(breedsViewController: breedsViewController, favoriteDogsViewController: favoriteDogs)
        }
    }

    func loaded(resolver: Resolver) {
        _ = resolver.resolve(UIKitNavigation.self)
    }
}
