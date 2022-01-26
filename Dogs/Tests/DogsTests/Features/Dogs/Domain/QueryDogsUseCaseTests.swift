import XCTest
import Combine
import Dogs

class QueryDogsUseCaseTests: XCTestCase {

    func test_uses_breed_to_trigger_resource() {
        var subscriptions = Set<AnyCancellable>()

        let selectedBreedUseCase = QuerySelectedBreedUseCaseStub()
        let dogsResource = DogsResourceSpy()
        let sut = QueryDogsUseCaseImpl(
            selectedBreedUseCase: selectedBreedUseCase,
            dogsResource: dogsResource
        )

        let useCaseBreed = Breed(identifier: "Dog", name: "pitbull")
        selectedBreedUseCase.subject.send(useCaseBreed)
        sut.query().sink(receiveValue: { _ in }).store(in: &subscriptions)

        XCTAssertEqual(dogsResource.queryBreed, useCaseBreed)
    }

    func test_returns_dogs_from_resource() {
        var subscriptions = Set<AnyCancellable>()
        let selectedBreedUseCase = QuerySelectedBreedUseCaseStub()
        let dogsResource = DogsResourceStub()
        let sut = QueryDogsUseCaseImpl(
            selectedBreedUseCase: selectedBreedUseCase,
            dogsResource: dogsResource
        )

        let breed = Breed(name: "pitbull")
        let dogs = [Dog(imageUrl: "Imageurl"), Dog(imageUrl: "http://image2")]
        selectedBreedUseCase.subject.send(breed)
        dogsResource.subject.send(dogs)

        let expectation = XCTestExpectation()

        sut.query()
            .sink { sutDogs in
                expectation.fulfill()
                XCTAssertEqual(dogs, sutDogs)
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: .leastNormalMagnitude)
    }
}

class DogsResourceStub: DogsResource {

    let subject = CurrentValueSubject<[Dog], Error>([])

    func query(breed: Breed) -> AnyPublisher<[Dog], Error> {
        return subject.eraseToAnyPublisher()
    }
}

class DogsResourceSpy: DogsResource {
    var queryBreed: Breed?

    func query(breed: Breed) -> AnyPublisher<[Dog], Error> {
        queryBreed = breed
        return Empty().eraseToAnyPublisher()
    }
}

class QuerySelectedBreedUseCaseStub: QuerySelectedBreedUseCase {

    let subject = CurrentValueSubject<Breed?, Never>(nil)

    func selectedBreed() -> AnyPublisher<Breed?, Never> {
        subject.eraseToAnyPublisher()
    }
}
