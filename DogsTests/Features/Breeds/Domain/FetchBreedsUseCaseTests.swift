//
//  FetchBreedsUseCaseTests.swift
//  DogsTests
//
//  Created by Libor Huspenina on 18.10.2021.
//

import XCTest
import Combine
import Dogs

class FetchBreedsUseCaseTests: XCTestCase {

    func test_fetch_prompts_repository() {
        let repository = BreedsRepositorySpy()
        let sut = FetchBreedsUseCaseImpl(repository: repository)

        sut.fetch()

        XCTAssertTrue(repository.fetchCalled)
    }
}
