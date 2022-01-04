import Foundation

public struct Breed: Equatable {
    public let identifier: ID
    public let name: String

    public init(identifier: ID = UUID().uuidString, name: String) {
        self.identifier = identifier
        self.name = name
    }
}
