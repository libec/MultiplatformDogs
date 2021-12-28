import Swinject

public struct DogsAssembly {

    public init() { }
    
    public let assemblies: [Assembly] = [
        APIAssembly(),
        BreedDetailAssembly(),
        BreedsAssembly(),
        InstanceProviderAssembly(),
        SelectedBreedsAssembly(),
    ]
}
