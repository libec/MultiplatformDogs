import Swinject
import SwinjectAutoregistration
import Dogs
import SwiftUI

class SwiftUIAppAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(BreedsView.self, initializer: BreedsView.init)
        container.autoregister(SwiftUINavigation.self, initializer: SwiftUINavigation.init).implements(Coordinator.self).inObjectScope(.container)
        container.autoregister(BreedDetailView.self, initializer: BreedDetailView.init)
        container.register(DogImage.self) { (resolver: Resolver, dog: DisplayableDog) in
            let imageResource = resolver.resolve(DogsImageResource.self)!
            let viewModel = resolver.resolve(DogViewModel.self, argument: dog)!
            return DogImage(dog: dog, viewModel: viewModel, imageResource: imageResource)
        }
        container.autoregister(RootView.self, initializer: RootView.init)
    }

    func loaded(resolver: Resolver) {

    }
}
