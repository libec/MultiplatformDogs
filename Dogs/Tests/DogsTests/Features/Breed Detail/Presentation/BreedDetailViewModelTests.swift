import Combine
import XCTest
import Dogs

class BreedsDetailViewModelTests: XCTestCase {

    func test_returns_displayable_dogs_formatted_from_use_case() {
        var subscriptions = Set<AnyCancellable>()

        let queryDogsUseCase = QueryDogsUseCaseStub()
        let queryFavoriteDogsUseCase = QueryFavoriteDogsUseCaseStub(dogs: [ ])
        let sut = BreedDetailViewModelImpl(
            queryDogsUseCase: queryDogsUseCase,
            queryFavoriteDogsUseCase: queryFavoriteDogsUseCase
        )

        let dogs = [
            Dog(imageUrl: "image1"),
            Dog(imageUrl: "image331"),
            Dog(imageUrl: "image901"),
            Dog(imageUrl: "image123"),
        ]
        queryDogsUseCase.subject.send(dogs)
        let expectation = XCTestExpectation()
        let expectedDisplayableDogs: [DisplayableDog] = [
            DisplayableDog(imageUrl: "image1", favorite: false),
            DisplayableDog(imageUrl: "image331", favorite: false),
            DisplayableDog(imageUrl: "image901", favorite: false),
            DisplayableDog(imageUrl: "image123", favorite: false),
        ]

        sut.output.sink { displayableDogs in
            XCTAssertEqual(displayableDogs, expectedDisplayableDogs)
            expectation.fulfill()
        }.store(in: &subscriptions)

        wait(for: [expectation], timeout: .leastNormalMagnitude)
    }

    func test_marks_favorite_dogs() {
        var subscriptions = Set<AnyCancellable>()

        let queryFavoriteDogsUseCase = QueryFavoriteDogsUseCaseStub(dogs: [
            Dog(imageUrl: "image331"),
            Dog(imageUrl: "image901")
        ])
        let queryDogsUseCase = QueryDogsUseCaseStub()
        let sut = BreedDetailViewModelImpl(
            queryDogsUseCase: queryDogsUseCase,
            queryFavoriteDogsUseCase: queryFavoriteDogsUseCase
        )

        let dogs = [
            Dog(imageUrl: "image1"),
            Dog(imageUrl: "image331"),
            Dog(imageUrl: "image901"),
            Dog(imageUrl: "image123"),
        ]
        queryDogsUseCase.subject.send(dogs)
        let expectation = XCTestExpectation()
        let expectedDisplayableDogs: [DisplayableDog] = [
            DisplayableDog(imageUrl: "image1", favorite: false),
            DisplayableDog(imageUrl: "image331", favorite: true),
            DisplayableDog(imageUrl: "image901", favorite: true),
            DisplayableDog(imageUrl: "image123", favorite: false),
        ]

        sut.output.sink { displayableDogs in
            XCTAssertEqual(displayableDogs, expectedDisplayableDogs)
            expectation.fulfill()
        }.store(in: &subscriptions)

        wait(for: [expectation], timeout: .leastNormalMagnitude)
    }
}

class QueryDogsUseCaseStub: QueryDogsUseCase {

    let subject = CurrentValueSubject<[Dog], Never>([])

    func query() -> AnyPublisher<[Dog], Never> {
        subject.eraseToAnyPublisher()
    }
}

class QueryFavoriteDogsUseCaseStub: QueryFavoriteDogsUseCase {

    let dogs: [Dog]

    init(dogs: [Dog]) {
        self.dogs = dogs
    }

    var query: AnyPublisher<[Dog], Never> {
        [dogs].publisher.eraseToAnyPublisher()
    }
}
