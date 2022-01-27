import Combine
import Foundation

public struct DisplayableBreed {
    public let identifier: ID
    public let name: String

    public init(identifier: ID, name: String) {
        self.name = name
        self.identifier = identifier
    }
}

public protocol BreedsViewModel {
    var output: AnyPublisher<[DisplayableBreed], Never> { get }
    func select(breed: ID)
    func fetchBreeds()
}

public final class BreedsViewModelImpl: BreedsViewModel {

    private let queryUseCase: QueryBreedsUseCase
    private let selectBreedUseCase: SelectBreedUseCase
    private let fetchBreedsUseCase: FetchBreedsUseCase

    public init(
        queryUseCase: QueryBreedsUseCase,
        selectBreedUseCase: SelectBreedUseCase,
        fetchBreedsUseCase: FetchBreedsUseCase
    ) {
        self.queryUseCase = queryUseCase
        self.selectBreedUseCase = selectBreedUseCase
        self.fetchBreedsUseCase = fetchBreedsUseCase
    }

    public var output: AnyPublisher<[DisplayableBreed], Never> {
        queryUseCase.query().map { breeds in
            breeds
                .sorted(by: { lhs, rhs in
                    lhs.name < rhs.name
                })
                .map { breed in
                    DisplayableBreed(identifier: breed.identifier, name: breed.name.capitalized)
                }
        }
        .eraseToAnyPublisher()
    }

    public func select(breed: ID) {
        selectBreedUseCase.select(breedID: breed)
    }

    public func fetchBreeds() {
        fetchBreedsUseCase.fetch()
    }
}
