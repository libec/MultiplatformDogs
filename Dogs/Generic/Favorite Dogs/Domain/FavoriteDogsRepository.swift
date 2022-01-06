import Combine

public protocol FavoriteDogsRepository {
    func add(dog: Dog)
    func remove(dog: Dog)
    var last: [Dog] { get }
    var favoriteDogs: AnyPublisher<[Dog], Never> { get }
}
