import Combine

public protocol Navigation {
    var showDogs: AnyPublisher<Bool, Never> { get }
}

public class NavigationImpl: Navigation {

    private let querySelectedBreedUseCase: QuerySelectedBreedUseCase

    public init(querySelectedBreedUseCase: QuerySelectedBreedUseCase) {
        self.querySelectedBreedUseCase = querySelectedBreedUseCase
    }

    public var showDogs: AnyPublisher<Bool, Never> {
        querySelectedBreedUseCase.selectedBreed()
            .map { breed in
                breed != nil
            }
            .eraseToAnyPublisher()
    }
}
