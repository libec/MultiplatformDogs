import Swinject
import SwinjectAutoregistration
import Dogs
import SwiftUI

class SwiftUIAppAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(BreedsView.self, initializer: BreedsView.init)
        container.autoregister(SwiftUINavigation.self, initializer: SwiftUINavigation.init).implements(Coordinator.self).inObjectScope(.container)
        container.autoregister(BreedsDetailView.self, initializer: BreedsDetailView.init)
    }

    func loaded(resolver: Resolver) {

    }
}
