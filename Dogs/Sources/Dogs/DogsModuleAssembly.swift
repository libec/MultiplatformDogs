import Swinject

public struct DogsModuleAssembly {

    public init() { }
    
    public let assemblies: [Assembly] = [
        APIAssembly(),
        DogsAssembly(),
        BreedsAssembly(),
        DogsImageResourceAssembly(),
        FavoriteDogsAssembly(),
        InstanceProviderAssembly(),
        NavigationAssembly(),
        SelectedBreedsAssembly(),
    ]
}
