import Swinject
import SwinjectAutoregistration

final class BreedDetailAssembly: Assembly {
    func assemble(container: Container) {

        container.autoregister(BreedDetailViewModel.self, initializer: BreedDetailViewModelImpl.init)
        container.autoregister(QueryDogsUseCase.self, initializer: QueryDogsUseCaseImpl.init)
        container.autoregister(BreedDetailResource.self, initializer: BreedDetailRemoteResource.init)

        container.register(BreedDetailViewModel.self) { (resolver: Resolver, strategy: BreedDetailDisplayStrategy) in
            let favoriteDogsUseCase = resolver.resolve(QueryFavoriteDogsUseCase.self)!
            switch strategy {
            case .specificBreed:
                return BreedDetailViewModelImpl(
                    queryDogsUseCase: resolver.resolve(QueryDogsUseCase.self)!,
                    queryFavoriteDogsUseCase: favoriteDogsUseCase)
            case .favorites:
                return FavoriteDogsViewModelImpl(
                    queryFavoriteDogsUseCase: favoriteDogsUseCase
                )
            }
        }

        container.register(DogViewModel.self) { resolver, displayableDog in
            DogViewModelImpl(
                displayableDog: displayableDog,
                useCase: resolver.resolve(ToggleFavoriteDogUseCase.self)!
            )
        }
    }
}
