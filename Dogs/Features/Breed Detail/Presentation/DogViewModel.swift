import Combine

public protocol DogViewModel {
    func toggleFavorite()
}

public final class DogViewModelImpl: DogViewModel {

    private let displayableDog: DisplayableDog

    public init(displayableDog: DisplayableDog) {
        self.displayableDog = displayableDog
    }

    public func toggleFavorite() {
        log("Dog Image tapped")
    }
}
