import Foundation
import Swinject
import Dogs

public struct AppStart {

    private var appAssemblies: [Assembly] = [
        UIKitAppAssembly()
    ] + DogsModuleAssembly().assemblies

    public init() { }

    public func startApp<Instance>() -> Instance {
        let assembler = Assembler()
        assembler.apply(assemblies: appAssemblies)
        return assembler.resolver.resolve(Instance.self)!
    }
}
