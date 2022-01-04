import Combine

public protocol BreedsResource {
    func fetch() -> AnyPublisher<[Breed], Error>
}
