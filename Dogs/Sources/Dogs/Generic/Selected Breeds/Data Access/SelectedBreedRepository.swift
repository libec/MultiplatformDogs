import Combine

public protocol SelectedBreedRepository {
    var selectedBreed: AnyPublisher<Breed?, Never> { get }
    func select(breed: Breed)
    func deselect()
}

public final class InMemorySelectedBreedRepository: SelectedBreedRepository {

    private let breedSubject = CurrentValueSubject<Breed?, Never>(nil)

    public var selectedBreed: AnyPublisher<Breed?, Never> {
        breedSubject.eraseToAnyPublisher()
    }

    public init() { }

    public func select(breed: Breed) {
        breedSubject.send(breed)
    }

    public func deselect() {
        breedSubject.send(nil)
    }
}
