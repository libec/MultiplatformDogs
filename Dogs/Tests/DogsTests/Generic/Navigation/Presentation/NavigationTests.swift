import XCTest
import Dogs
import Combine

class NavigationTests: XCTestCase {

    func test_breed_selection_shows_dogs() {
        let querySelectedBreedUseCase = QuerySelectedBreedUseCaseStub()
        let sut = NavigationImpl(querySelectedBreedUseCase: querySelectedBreedUseCase)
        var subscriptions = Set<AnyCancellable>()

        let expectation = XCTestExpectation()
        querySelectedBreedUseCase.subject.send(Breed(name: "Vizsla"))

        sut.showDogs
            .sink { showDogs in
                XCTAssertTrue(showDogs)
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: .leastNormalMagnitude)
    }

    func test_breed_deselection_hides_dogs() {
        let querySelectedBreedUseCase = QuerySelectedBreedUseCaseStub()
        let sut = NavigationImpl(querySelectedBreedUseCase: querySelectedBreedUseCase)
        var subscriptions = Set<AnyCancellable>()

        let expectation = XCTestExpectation()
        querySelectedBreedUseCase.subject.send(nil)

        sut.showDogs
            .sink { showDogs in
                XCTAssertFalse(showDogs)
                expectation.fulfill()
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: .leastNormalMagnitude)
    }
}
