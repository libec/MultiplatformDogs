import Combine

public protocol DogViewModel {
    func toggleFavorite()
}

public final class DogViewModelImpl: DogViewModel {

    private let displayableDog: DisplayableDog
    private let useCase: ToggleFavoriteDogUseCase

    public init(displayableDog: DisplayableDog, useCase: ToggleFavoriteDogUseCase) {
        self.displayableDog = displayableDog
        self.useCase = useCase
    }

    public func toggleFavorite() {
        useCase.toggle(request: .init(url: displayableDog.imageUrl))
    }
}
