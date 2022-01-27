import Swinject
import SwinjectAutoregistration

final class BreedsAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(BreedsResource.self, initializer: BreedsRemoteResource.init)
        container.autoregister(BreedsRepository.self, initializer: BreedsLocalRepository.init)
            .inObjectScope(.container)
        container.autoregister(QueryBreedsUseCase.self, initializer: QueryBreedsUseCaseImpl.init)
        container.autoregister(BreedsViewModel.self, initializer: BreedsViewModelImpl.init)
        container.autoregister(FetchBreedsUseCase.self, initializer: FetchBreedsUseCaseImpl.init)
    }
}
