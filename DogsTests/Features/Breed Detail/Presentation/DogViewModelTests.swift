import XCTest
import Combine
import Dogs

class DogViewModelTests: XCTestCase {

    func test_toggle_favorite_invokes_use_case() {
        let displayableDog = DisplayableDog(imageUrl: "dog_image", favorite: false)
        let toggleFavoriteUseCase = ToggleFavoriteDogUseCaseSpy()
        let sut = DogViewModelImpl(displayableDog: displayableDog, useCase: toggleFavoriteUseCase)

        sut.toggleFavorite()

        XCTAssertEqual(toggleFavoriteUseCase.toggleRequest?.url, "dog_image")
    }
}

class ToggleFavoriteDogUseCaseSpy: ToggleFavoriteDogUseCase {

    var toggleRequest: ToggleFavoriteDogRequest?

    func toggle(request: ToggleFavoriteDogRequest) {
        self.toggleRequest = request
    }
}
