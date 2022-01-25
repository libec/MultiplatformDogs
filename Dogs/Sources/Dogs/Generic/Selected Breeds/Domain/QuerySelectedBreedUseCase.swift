import Combine

public protocol QuerySelectedBreedUseCase {
    func selectedBreed() -> AnyPublisher<Breed?, Never>
}

public final class QuerySelectedBreedUseCaseImpl: QuerySelectedBreedUseCase {

    private let selectedBreedRepository: SelectedBreedRepository

    public init(selectedBreedRepository: SelectedBreedRepository) {
        self.selectedBreedRepository = selectedBreedRepository
    }

    public func selectedBreed() -> AnyPublisher<Breed?, Never> {
        selectedBreedRepository.selectedBreed
    }
}
