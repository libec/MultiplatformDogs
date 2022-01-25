import Combine

final class InMemoryFavoriteDogsRepository: FavoriteDogsRepository {

    private var dogs = CurrentValueSubject<[Dog], Never>([])

    init() { }

    func add(dog: Dog) {
        dogs.value.append(dog)
    }

    func remove(dog: Dog) {
        if dogs.value.contains(dog) {
            dogs.value.removeAll { collectionDog in
                collectionDog == dog
            }
        }
    }

    var last: [Dog] {
        dogs.value
    }

    var favoriteDogs: AnyPublisher<[Dog], Never> {
        dogs.eraseToAnyPublisher()
    }
}
