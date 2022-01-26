import Swinject
import SwinjectAutoregistration
import Dogs
import SwiftUI

class MacOSAppAssembly: Assembly {
    func assemble(container: Container) {
        container.register(RootView.self) { resolver in
            let dogsView = resolver.resolve(DogsView.self, argument: BreedDetailDisplayStrategy.specificBreed)!
            let favoriteDogs = resolver.resolve(DogsView.self, argument: BreedDetailDisplayStrategy.favorites)!
            return RootView(
                breedsView: resolver.resolve(BreedsView.self)!,
                dogsView: dogsView,
                favoriteDogs: favoriteDogs,
                navigation: resolver.resolve(Navigation.self)!
            )
        }

        container.autoregister(BreedsView.self, initializer: BreedsView.init)

        container.register(DogsView.self) { (resolver: Resolver, strategy: BreedDetailDisplayStrategy) in
            DogsView(
                viewModel: resolver.resolve(BreedDetailViewModel.self, argument: strategy)!,
                instanceProvider: resolver.resolve(InstanceProvider.self)!
            )
        }

        container.autoregister(Navigation.self, initializer: Navigation.init)
            .inObjectScope(.container)

        container.register(DogImage.self) { (resolver: Resolver, dog: DisplayableDog) in
            return DogImage(
                dog: dog,
                viewModel: resolver.resolve(DogViewModel.self, argument: dog)!,
                imageResource: resolver.resolve(DogsImageResource.self)!
            )
        }
    }
}
