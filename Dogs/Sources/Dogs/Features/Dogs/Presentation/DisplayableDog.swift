public struct DisplayableDog: Equatable {

    public let imageUrl: String
    public let favorite: Bool

    public init(imageUrl: String, favorite: Bool) {
        self.imageUrl = imageUrl
        self.favorite = favorite
    }
}
