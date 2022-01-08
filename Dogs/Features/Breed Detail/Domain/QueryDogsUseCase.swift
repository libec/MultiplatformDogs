import Combine

enum QueryDogsRequest {
    case favorite
    case selected
}

struct QueryDogsResponse {
    let imageUrl: String
    let favorite: Bool
}

public protocol QueryDogsUseCase {
    func query() -> AnyPublisher<[Dog], Never>
}

public struct QueryDogsUseCaseImpl: QueryDogsUseCase {

    private let selectedBreedUseCase: QuerySelectedBreedUseCase
    private let breedDetailResource: BreedDetailResource

    public init(selectedBreedUseCase: QuerySelectedBreedUseCase, breedDetailResource: BreedDetailResource) {
        self.selectedBreedUseCase = selectedBreedUseCase
        self.breedDetailResource = breedDetailResource
    }

    public func query() -> AnyPublisher<[Dog], Never> {
        selectedBreedUseCase.selectedBreed()
            .flatMap { breed -> AnyPublisher<[Dog], Never> in
                if let breed = breed {
                    return breedDetailResource
                        .query(breed: breed)
                        .replaceError(with: [])
                        .eraseToAnyPublisher()
                } else {
                    return [].publisher.eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
