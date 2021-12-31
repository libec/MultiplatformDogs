import Combine
import Foundation

public struct DisplayableDog: Equatable {

    public let imageUrl: String
    public let favorite: Bool

    public init(imageUrl: String, favorite: Bool) {
        self.imageUrl = imageUrl
        self.favorite = favorite
    }
}

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
