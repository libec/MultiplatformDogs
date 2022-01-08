import Combine
import Foundation

public protocol BreedDetailViewModel {
    var output: AnyPublisher<[DisplayableDog], Never> { get }
}

public final class BreedDetailViewModelImpl: BreedDetailViewModel {

    private let queryDogsUseCase: QueryDogsUseCase
    private let queryFavoriteDogsUseCase: QueryFavoriteDogsUseCase

    public init(
        queryDogsUseCase: QueryDogsUseCase,
        queryFavoriteDogsUseCase: QueryFavoriteDogsUseCase
    ) {
        self.queryDogsUseCase = queryDogsUseCase
        self.queryFavoriteDogsUseCase = queryFavoriteDogsUseCase
    }

    public var output: AnyPublisher<[DisplayableDog], Never> {
        queryDogsUseCase.query()
            .combineLatest(queryFavoriteDogsUseCase.query)
            .map { dogs, favoriteDogs in
                dogs.map { dog in
                    DisplayableDog(imageUrl: dog.imageUrl, favorite: favoriteDogs.contains(dog))
                }
            }
            .eraseToAnyPublisher()
    }
}
