import Combine
import Foundation

public final class DogsRemoteResource: DogsResource {

    private let apiConfiguration: APIConfiguration
    private var subscriptions: AnyCancellable?

    public init(apiConfiguration: APIConfiguration) {
        self.apiConfiguration = apiConfiguration
    }

    public func query(breed: Breed) -> AnyPublisher<[Dog], Error> {
        let url = URL(string: apiConfiguration.baseURL + "/breed/\(breed.name)/images")!
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: DogsResourceDto.self, decoder: JSONDecoder())
            .map { dto in
                dto.breeds.map { dogImageUrl in
                    Dog(imageUrl: dogImageUrl)
                }
            }
            .eraseToAnyPublisher()
    }
}

fileprivate struct DogsResourceDto: Codable {
    fileprivate let breeds: [String]

    fileprivate enum CodingKeys: String, CodingKey {
        case breeds = "message"

    }
}
