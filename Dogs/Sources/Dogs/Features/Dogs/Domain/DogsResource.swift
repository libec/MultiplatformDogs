import Combine

public protocol DogsResource {
    func query(breed: Breed) -> AnyPublisher<[Dog], Error>
}
