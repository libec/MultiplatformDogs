@testable import Dogs
import Combine
import XCTest

class FavoriteDogsRepositoryTest: XCTestCase {
    func test_added_dogs_are_accessible_in_last() {
        let sut = InMemoryFavoriteDogsRepository()

        let dog1 = Dog(imageUrl: "dog1")
        sut.add(dog: dog1)

        let dog2 = Dog(imageUrl: "dog12_!3")
        sut.add(dog: dog2)

        let dog3 = Dog(imageUrl: "dog3")
        sut.add(dog: dog3)

        let addedDogs = sut.last

        XCTAssertTrue(addedDogs.contains(dog1))
        XCTAssertTrue(addedDogs.contains(dog2))
        XCTAssertTrue(addedDogs.contains(dog3))
    }

    func test_removed_dogs_are_not_in_last() {
        let sut = InMemoryFavoriteDogsRepository()

        let dog1 = Dog(imageUrl: "dog1")
        sut.add(dog: dog1)

        let dog2 = Dog(imageUrl: "dog12_!3")
        sut.add(dog: dog2)

        let dog3 = Dog(imageUrl: "dog3")
        sut.add(dog: dog3)

        sut.remove(dog: dog2)

        let addedDogs = sut.last

        XCTAssertTrue(addedDogs.contains(dog1))
        XCTAssertFalse(addedDogs.contains(dog2))
        XCTAssertTrue(addedDogs.contains(dog3))
    }

    func test_publisher_emits_when_adding_dogs() {
        let sut = InMemoryFavoriteDogsRepository()
        var subscriptions = Set<AnyCancellable>()

        let dog1 = Dog(imageUrl: "dog1")
        sut.add(dog: dog1)

        let expectation = XCTestExpectation()
        sut.favoriteDogs
            .sink { dogs in
                expectation.fulfill()
                XCTAssertEqual(dogs, sut.last)
                XCTAssertEqual(dogs, [dog1])
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: .leastNormalMagnitude)
    }

    func test_publisher_emits_when_removing_dogs() {
        let sut = InMemoryFavoriteDogsRepository()
        var subscriptions = Set<AnyCancellable>()

        let dog1 = Dog(imageUrl: "dog1")
        sut.add(dog: dog1)
        sut.remove(dog: dog1)

        let expectation = XCTestExpectation()
        sut.favoriteDogs
            .sink { dogs in
                expectation.fulfill()
                XCTAssertEqual(dogs, sut.last)
                XCTAssertEqual(dogs, [])
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: .leastNormalMagnitude)
    }
}
