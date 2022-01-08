import Combine
import XCTest
import Dogs

class BreedsViewModelTests: XCTestCase {

    func test_when_query_updates_then_view_updates_with_formatted_and_sorted_names() {
        var subscriptions = Set<AnyCancellable>()
        let useCaseBreeds = [Breed(name: "viszla"), Breed(name: "dalmatian"), Breed(name: "cocker spaniel")]
        let queryBreedsUseCase = QueryBreedsUseCaseStub(breeds: useCaseBreeds)
        let sut = BreedsViewModelImpl(
            queryUseCase: queryBreedsUseCase,
            selectBreedUseCase: SelectBreedUseCaseDummy()
        )

        let expectation = XCTestExpectation()
        sut.output
            .sink { output in
                XCTAssertEqual(["Cocker Spaniel", "Dalmatian", "Viszla"], output.map(\.name))
                expectation.fulfill()
            }
            .store(in: &subscriptions)


        wait(for: [expectation], timeout: .leastNonzeroMagnitude)
    }

    func test_selected_breed_is_passed_to_use_case() {
        let useCaseBreeds = [Breed( name: "dalmatian"), Breed(name: "cocker spaniel"), Breed(name: "chihuaha")]
        let queryBreedsUseCase = QueryBreedsUseCaseStub(breeds: useCaseBreeds)
        let selectBreedUseCase = SelectBreedUseCaseSpy()
        let sut = BreedsViewModelImpl(
            queryUseCase: queryBreedsUseCase,
            selectBreedUseCase: selectBreedUseCase
        )
        sut.select(breed: "Dog_123_11")

        XCTAssertEqual(selectBreedUseCase.selectedBreedId, "Dog_123_11")
    }
}

typealias SelectBreedUseCaseDummy = SelectBreedUseCaseSpy

class SelectBreedUseCaseSpy: SelectBreedUseCase {

    var selectedBreedId: ID?

    func select(breedID: ID) {
        self.selectedBreedId = breedID
    }
}

class QueryBreedsUseCaseDummy: QueryBreedsUseCase {
    func query() -> AnyPublisher<[Breed], Never> {
        Empty().eraseToAnyPublisher()
    }
}

class QueryBreedsUseCaseStub: QueryBreedsUseCase {
    let breedSubject: CurrentValueSubject<[Breed], Never>
    init(breeds: [Breed]) {
        self.breedSubject = CurrentValueSubject<[Breed], Never>(breeds)
    }

    func query() -> AnyPublisher<[Breed], Never> {
        breedSubject.eraseToAnyPublisher()
    }
}
