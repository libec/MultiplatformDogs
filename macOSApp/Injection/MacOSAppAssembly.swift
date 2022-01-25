import Swinject
import SwinjectAutoregistration
import Dogs
import SwiftUI

class MacOSAppAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(RootView.self, initializer: RootView.init)
    }
}
