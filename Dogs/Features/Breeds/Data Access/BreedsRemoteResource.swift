import Combine
import Foundation

public final class BreedsRemoteResource: BreedsResource {

    private let apiConfiguration: APIConfiguration
    private var subscriptions: AnyCancellable?

    public init(apiConfiguration: APIConfiguration) {
        self.apiConfiguration = apiConfiguration
    }

    public func fetch() -> AnyPublisher<[Breed], Error> {
        let url = URL(string: apiConfiguration.baseURL + "/breeds/list/all")!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: BreedResourceDto.self, decoder: JSONDecoder())
            .map { dto in dto.breeds.keys.map { Breed(name: $0) } }
            .eraseToAnyPublisher()
    }
}

fileprivate struct BreedResourceDto: Codable {
    fileprivate let breeds: [String: [String]]

    fileprivate enum CodingKeys: String, CodingKey {
        case breeds = "message"
    }
}
