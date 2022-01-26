import Combine

public final class FavoriteDogsViewModelImpl: DogsViewModel {

    private let queryFavoriteDogsUseCase: QueryFavoriteDogsUseCase

    public init(queryFavoriteDogsUseCase: QueryFavoriteDogsUseCase) {
        self.queryFavoriteDogsUseCase = queryFavoriteDogsUseCase
    }

    public var output: AnyPublisher<[DisplayableDog], Never> {
        queryFavoriteDogsUseCase.query
            .map { dogs in
                dogs.map {
                    DisplayableDog(imageUrl: $0.imageUrl, favorite: true)
                }
            }
            .eraseToAnyPublisher()
    }
}
