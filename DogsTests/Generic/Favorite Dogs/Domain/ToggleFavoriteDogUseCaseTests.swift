import Combine
import Dogs
import XCTest

class ToggleFavoriteDogUseCaseTests: XCTestCase {

    func test_toggles_unfavorite_dog_to_favorite_in_repository() {
        let urls = ["Dog1", "Dog_23", "Dob"]
        let repositoryDogs = urls.map(Dog.init)
        let repository = FavoriteDogsRepositoryFake(lastDogsToReturn: repositoryDogs)
        let sut = ToggleFavoriteDogUseCaseImpl(repository: repository)

        sut.toggle(request: ToggleFavoriteDogRequest(url: "Dog_411"))

        XCTAssertEqual("Dog_411", repository.addedDog?.imageUrl)
    }

    func test_doesnt_add_already_favorite_dog() {
        let urls = ["Dog1", "Dog_23", "Dob"]
        let repositoryDogs = urls.map(Dog.init)
        let repository = FavoriteDogsRepositoryFake(lastDogsToReturn: repositoryDogs)
        let sut = ToggleFavoriteDogUseCaseImpl(repository: repository)

        sut.toggle(request: ToggleFavoriteDogRequest(url: "Dog1"))

        XCTAssertNil(repository.addedDog)
    }

    func test_toggles_favorite_dog_to_unfavorite_in_repository() {
        let urls = ["Dog1", "Dog_23", "Dob"]
        let repositoryDogs = urls.map(Dog.init)
        let repository = FavoriteDogsRepositoryFake(lastDogsToReturn: repositoryDogs)
        let sut = ToggleFavoriteDogUseCaseImpl(repository: repository)

        sut.toggle(request: ToggleFavoriteDogRequest(url: "Dog_23"))

        XCTAssertEqual("Dog_23", repository.removedDog?.imageUrl)
    }

    func test_doesnt_remove_already_unfavorite_dog() {
        let urls = ["Dog1", "Dog_23", "Dob"]
        let repositoryDogs = urls.map(Dog.init)
        let repository = FavoriteDogsRepositoryFake(lastDogsToReturn: repositoryDogs)
        let sut = ToggleFavoriteDogUseCaseImpl(repository: repository)

        sut.toggle(request: ToggleFavoriteDogRequest(url: "Dog_21_22"))

        XCTAssertNil(repository.removedDog)
    }
}

class FavoriteDogsRepositoryFake: FavoriteDogsRepository {

    var addedDog: Dog?
    var removedDog: Dog?
    let last: [Dog]

    init(lastDogsToReturn: [Dog]) {
        self.last = lastDogsToReturn
    }

    func add(dog: Dog) {
        addedDog = dog
    }

    func remove(dog: Dog) {
        removedDog = dog
    }

    var favoriteDogs: AnyPublisher<[Dog], Never> {
        [last].publisher.eraseToAnyPublisher()
    }
}
