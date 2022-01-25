import Foundation

public protocol APIConfiguration {
    var baseURL: String { get }
}

public struct ProductionAPIConfiguration: APIConfiguration {

    public let baseURL = "https://dog.ceo/api"

    public init() { } 
}
