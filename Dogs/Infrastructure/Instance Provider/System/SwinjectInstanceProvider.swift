import Swinject

class SwinjectInstanceProvider: InstanceProvider {

    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func resolve<Instance>(_ type: Instance.Type) -> Instance {
        resolver.resolve(type)!
    }

    func resolve<Instance, Argument>(_ type: Instance.Type, argument: Argument) -> Instance {
        resolver.resolve(type, argument: argument)!
    }
}
