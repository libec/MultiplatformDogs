import Swinject

class DogsImageResourceAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(DogsImageResource.self, initializer: DogsImageCachedResource.init).inObjectScope(.container)
    }
}
