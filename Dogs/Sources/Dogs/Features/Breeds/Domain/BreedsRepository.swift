import Foundation
import Combine

public protocol BreedsRepository {
    func fetch()
    var query: AnyPublisher<[Breed], Never> { get }
    var last: [Breed] { get }
}
