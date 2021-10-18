//
//  IntegrationTests.swift
//  IntegrationTests
//
//  Created by Libor Huspenina on 17.10.2021.
//

import XCTest
import Combine
import Dogs

class BreedRemoteResourceTests: XCTestCase {

    var subscriptions = Set<AnyCancellable>()

    func test_fetched_remote_resource() {
        let apiConfiguration = ProductionAPIConfiguration()
        let sut = BreedsRemoteResource(apiConfiguration: apiConfiguration)

        let expectation = XCTestExpectation()

        sut.fetch()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Error \(error.localizedDescription) not expected")
                case .finished:
                    expectation.fulfill()
                }
            } receiveValue: { breeds in
                log("\(breeds)")
                XCTAssertFalse(breeds.isEmpty)
            }
            .store(in: &subscriptions)

        wait(for: [expectation], timeout: 3)
    }
}
