
import Swinject
import SwinjectAutoregistration

class NavigationAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(Navigation.self, initializer: NavigationImpl.init)
            .inObjectScope(.container)
    }
}
