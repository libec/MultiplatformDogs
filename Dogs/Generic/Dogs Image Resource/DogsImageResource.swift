import Foundation
import Combine

public protocol DogsImageResource {
    func imageData(for url: URL) -> AnyPublisher<Data?, Never>
}

public final class DogsImageCachedResource: DogsImageResource {

    private var dogs: [String: Data?] = [:]
    var subscriptions = Set<AnyCancellable>()

    public init() { }

    public func imageData(for url: URL) -> AnyPublisher<Data?, Never> {
        if let image = dogs[url.path] {
            return Just(image).eraseToAnyPublisher()
        } else {
            return URLSession.shared
                .dataTaskPublisher(for: url)
                .map { $0.data }
                .replaceError(with: nil)
                .handleEvents(receiveOutput: { [unowned self] data in
                    self.dogs[url.path] = data
                })
                .eraseToAnyPublisher()

        }
    }
}

