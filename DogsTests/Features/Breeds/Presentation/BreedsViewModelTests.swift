//
//  BreedsViewModelTests.swift
//  DogsTests
//
//  Created by Libor Huspenina on 18.10.2021.
//

import Combine
import XCTest
import Dogs

class BreedsViewModelTests: XCTestCase {

    func test_when_query_updates_then_view_updates_with_formatted_names() {
        var subscriptions = Set<AnyCancellable>()
        let useCaseBreeds = [Breed(name: "dalmatian"), Breed(name: "cocker spaniel")]
        let queryBreedsUseCase = QueryBreedsUseCaseStub(breeds: useCaseBreeds)
        let sut = BreedsViewModelImpl(fetchUseCase: FetchUseCaseDummy(), queryUseCase: queryBreedsUseCase)

        let expectation = XCTestExpectation()
        sut.output
            .sink { output in
                XCTAssertEqual(["Dalmatian", "Cocker Spaniel"], output.breedNames)
                expectation.fulfill()
            }
            .store(in: &subscriptions)


        wait(for: [expectation], timeout: .leastNonzeroMagnitude)
    }

    func test_fetch_starts_use_case() {
        let fetchUseCase = FetchBreedsUseCaseSpy()
        let sut = BreedsViewModelImpl(fetchUseCase: fetchUseCase, queryUseCase: QueryBreedsUseCaseDummy())

        sut.fetch()

        XCTAssertTrue(fetchUseCase.fetchCalled)
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

typealias FetchUseCaseDummy = FetchBreedsUseCaseSpy

class FetchBreedsUseCaseSpy: FetchBreedsUseCase {

    var fetchCalled = false

    func fetch() {
        fetchCalled = true
    }
}
