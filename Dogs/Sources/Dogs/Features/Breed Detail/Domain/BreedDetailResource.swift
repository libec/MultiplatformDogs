import Combine

public protocol BreedDetailResource {
    func query(breed: Breed) -> AnyPublisher<[Dog], Error>
}
