import XCTest
import Dogs
import Combine

class FavoriteDogsViewModelTests: XCTestCase {

    func test_shows_all_dogs_from_favorite_use_case_as_favorite() {
        var subscriptions = Set<AnyCancellable>()

        let queryFavoriteDogsUseCase = QueryFavoriteDogsUseCaseStub(dogs: [
            Dog(imageUrl: "image331"),
            Dog(imageUrl: "ima901"),
            Dog(imageUrl: "_12_viszla"),
        ])
        let sut = FavoriteDogsViewModelImpl(
            queryFavoriteDogsUseCase: queryFavoriteDogsUseCase
        )
        let expectation = XCTestExpectation()
        let expectedDisplayableDogs: [DisplayableDog] = [
            DisplayableDog(imageUrl: "image331", favorite: true),
            DisplayableDog(imageUrl: "ima901", favorite: true),
            DisplayableDog(imageUrl: "_12_viszla", favorite: true),
        ]

        sut.output.sink { displayableDogs in
            XCTAssertEqual(displayableDogs, expectedDisplayableDogs)
            expectation.fulfill()
        }.store(in: &subscriptions)

        wait(for: [expectation], timeout: .leastNormalMagnitude)    }
}
