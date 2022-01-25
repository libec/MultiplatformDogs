import Swinject
import SwinjectAutoregistration

final class APIAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(APIConfiguration.self, initializer: ProductionAPIConfiguration.init)
    }
}
