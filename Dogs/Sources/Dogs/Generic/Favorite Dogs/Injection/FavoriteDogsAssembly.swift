import Swinject
import SwinjectAutoregistration

class FavoriteDogsAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(FavoriteDogsRepository.self, initializer: InMemoryFavoriteDogsRepository.init)
            .inObjectScope(.container)
        container.autoregister(QueryFavoriteDogsUseCase.self, initializer: QueryFavoriteDogsUseCaseImpl.init)
        container.autoregister(ToggleFavoriteDogUseCase.self, initializer: ToggleFavoriteDogUseCaseImpl.init)
    }
}
