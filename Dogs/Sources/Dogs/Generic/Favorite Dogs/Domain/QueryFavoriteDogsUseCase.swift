import Combine

public protocol QueryFavoriteDogsUseCase {
    var query: AnyPublisher<[Dog], Never> { get }
}

public final class QueryFavoriteDogsUseCaseImpl: QueryFavoriteDogsUseCase {

    private let repository: FavoriteDogsRepository

    public var query: AnyPublisher<[Dog], Never> {
        repository.favoriteDogs
    }

    public init(repository: FavoriteDogsRepository) {
        self.repository = repository
    }
}
