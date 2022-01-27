import Foundation
import Combine

public protocol BreedsRepository {
    func fetch()
    var query: AnyPublisher<[Breed], Never> { get }
    var last: [Breed] { get }
}

public final class BreedsLocalRepository: BreedsRepository {

    private let breedsResource: BreedsResource

    private let subject = CurrentValueSubject<[Breed], Never>([])
    private var subscriptions = Set<AnyCancellable>()

    public init(breedsResource: BreedsResource) {
        self.breedsResource = breedsResource
    }

    public func fetch() {
        breedsResource.fetch()
            .replaceError(with: [])
            .sink { [weak self] breed in
                guard let unwrappedSelf = self else { return }
                unwrappedSelf.subject.send(breed)
            }.store(in: &subscriptions)
    }

    public var query: AnyPublisher<[Breed], Never> {
        subject
            .eraseToAnyPublisher()
    }

    public var last: [Breed] {
        subject.value
    }
}
