import Swinject
import SwinjectAutoregistration

final class DogsAssembly: Assembly {
    func assemble(container: Container) {

        container.autoregister(DogsViewModel.self, initializer: DogsViewModelImpl.init)
        container.autoregister(QueryDogsUseCase.self, initializer: QueryDogsUseCaseImpl.init)
        container.autoregister(DogsResource.self, initializer: DogsRemoteResource.init)

        container.register(DogsViewModel.self) { (resolver: Resolver, strategy: DogsDisplayStrategy) in
            let favoriteDogsUseCase = resolver.resolve(QueryFavoriteDogsUseCase.self)!
            switch strategy {
            case .specificBreed:
                return DogsViewModelImpl(
                    queryDogsUseCase: resolver.resolve(QueryDogsUseCase.self)!,
                    queryFavoriteDogsUseCase: favoriteDogsUseCase)
            case .favorites:
                return FavoriteDogsViewModelImpl(
                    queryFavoriteDogsUseCase: favoriteDogsUseCase
                )
            }
        }
        .inObjectScope(.transient)

        container.register(DogViewModel.self) { resolver, displayableDog in
            DogViewModelImpl(
                displayableDog: displayableDog,
                useCase: resolver.resolve(ToggleFavoriteDogUseCase.self)!
            )
        }
    }
}
