import Swinject
import SwinjectAutoregistration
import Dogs
import SwiftUI

class SwiftUIAppAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(BreedsView.self, initializer: BreedsView.init)
        container.autoregister(SwiftUINavigation.self, initializer: SwiftUINavigation.init).inObjectScope(.container)
        container.register(DogsView.self) { (resolver: Resolver, strategy: DogsDisplayStrategy) in
            DogsView(
                DogsViewModel: resolver.resolve(DogsViewModel.self, argument: strategy)!,
                instanceProvider: resolver.resolve(InstanceProvider.self)!)
        }
        container.register(DogImage.self) { (resolver: Resolver, dog: DisplayableDog) in
            let imageResource = resolver.resolve(DogsImageResource.self)!
            let viewModel = resolver.resolve(DogViewModel.self, argument: dog)!
            return DogImage(dog: dog, viewModel: viewModel, imageResource: imageResource)
        }
        container.register(RootView.self) { resolver in
            RootView(
                breedView: resolver.resolve(BreedsView.self)!,
                favoriteDogsView: resolver.resolve(DogsView.self, argument: DogsDisplayStrategy.favorites)!
            )
        }
    }
}
