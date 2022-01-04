import XCTest
import Dogs

class APIConfigurationTests: XCTestCase {

    func test_uses_proper_production_base_url() throws {
        let sut = ProductionAPIConfiguration()

        let baseUrl = sut.baseURL

        XCTAssertEqual(baseUrl, "https://dog.ceo/api")
    }
}
