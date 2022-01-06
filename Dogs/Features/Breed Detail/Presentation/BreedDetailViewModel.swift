import Combine
import Foundation

public protocol BreedDetailViewModel {
    var output: AnyPublisher<[DisplayableDog], Never> { get }
}

public final class BreedDetailViewModelImpl: BreedDetailViewModel {

    private let queryDogsUseCase: QueryDogsUseCase

    public var output: AnyPublisher<[DisplayableDog], Never> {
        queryDogsUseCase.query()
            .map { dogs in
                dogs.map { dog in
                    DisplayableDog(imageUrl: dog.imageUrl, favorite: false)
                }
            }
            .eraseToAnyPublisher()
    }

    public init(queryDogsUseCase: QueryDogsUseCase) {
        self.queryDogsUseCase = queryDogsUseCase
    }
}
