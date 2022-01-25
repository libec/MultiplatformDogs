import Foundation
import Combine

public protocol DogsImageResource {
    func imageData(for url: URL) async throws -> Data?
}

public actor DogsImageCachedResource: DogsImageResource {

    private var dogs: [String: Data?] = [:]
    var subscriptions = Set<AnyCancellable>()

    public init() { }

    public func imageData(for url: URL) async throws -> Data? {
        if let image = dogs[url.path] {
            return image
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        dogs[url.path] = data
        return data
    }
}

