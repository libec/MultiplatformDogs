import Combine

struct QueryDogsResponse {
    let imageUrl: String
    let favorite: Bool
}

public protocol QueryDogsUseCase {
    func query() -> AnyPublisher<[Dog], Never>
}

public struct QueryDogsUseCaseImpl: QueryDogsUseCase {

    private let selectedBreedUseCase: QuerySelectedBreedUseCase
    private let dogsResource: DogsResource

    public init(
        selectedBreedUseCase: QuerySelectedBreedUseCase,
        dogsResource: DogsResource
    ) {
        self.selectedBreedUseCase = selectedBreedUseCase
        self.dogsResource = dogsResource
    }

    public func query() -> AnyPublisher<[Dog], Never> {
        selectedBreedUseCase.selectedBreed()
            .flatMap { breed -> AnyPublisher<[Dog], Never> in
                if let breed = breed {
                    return dogsResource
                        .query(breed: breed)
                        .replaceError(with: [])
                        .eraseToAnyPublisher()
                } else {
                    return [].publisher.eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
