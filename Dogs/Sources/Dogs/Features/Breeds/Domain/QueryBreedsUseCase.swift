import Combine

public protocol QueryBreedsUseCase {
    func query() -> AnyPublisher<[Breed], Never>
}

public final class QueryBreedsUseCaseImpl: QueryBreedsUseCase {

    private let repository: BreedsRepository

    public init(repository: BreedsRepository) {
        self.repository = repository
    }

    public func query() -> AnyPublisher<[Breed], Never> {
        repository.query
    }
}
