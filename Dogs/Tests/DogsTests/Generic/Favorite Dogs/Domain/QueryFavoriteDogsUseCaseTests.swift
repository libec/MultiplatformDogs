import Combine
import XCTest
import Dogs

class QueryFavoriteDogsUseCaseTests: XCTestCase {

    func test_queries_repository_for_favorite_dogs() {
        let repositoryDogs = ["dog1", "D3a", "31"].map(Dog.init)
        let subject = PassthroughSubject<[Dog], Never>()
        let repository = FavoriteDogsRepositoryStub(favoriteDogs: subject)
        let sut = QueryFavoriteDogsUseCaseImpl(repository: repository)

        var subscriptions = Set<AnyCancellable>()
        let expectation = XCTestExpectation()

        sut.query.sink { dogs in
            XCTAssertEqual(dogs, repositoryDogs)
            expectation.fulfill()
        }
        .store(in: &subscriptions)
        
        subject.send(repositoryDogs)

        wait(for: [expectation], timeout: .leastNormalMagnitude)
    }
}

class FavoriteDogsRepositoryStub: FavoriteDogsRepository {

    private let favoriteDogsSubject: PassthroughSubject<[Dog], Never>

    init(favoriteDogs: PassthroughSubject<[Dog], Never>) {
        self.favoriteDogsSubject = favoriteDogs
    }

    func add(dog: Dog) {

    }

    func remove(dog: Dog) {

    }

    var last: [Dog] = []

    var favoriteDogs: AnyPublisher<[Dog], Never> {
        favoriteDogsSubject.eraseToAnyPublisher()
    }
}
