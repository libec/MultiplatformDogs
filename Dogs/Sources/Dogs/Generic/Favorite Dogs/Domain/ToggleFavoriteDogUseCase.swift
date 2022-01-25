public struct ToggleFavoriteDogRequest {

    public let url: String

    public init(url: String) {
        self.url = url
    }
}

public protocol ToggleFavoriteDogUseCase {
    func toggle(request: ToggleFavoriteDogRequest)
}

public final class ToggleFavoriteDogUseCaseImpl: ToggleFavoriteDogUseCase {

    private let repository: FavoriteDogsRepository

    public init(repository: FavoriteDogsRepository) {
        self.repository = repository
    }

    public func toggle(request: ToggleFavoriteDogRequest) {
        let favoriteDogFromRepository = repository.last.first(where: { dog in
            dog.imageUrl == request.url
        })
        if let favoriteDog = favoriteDogFromRepository {
            repository.remove(dog: favoriteDog)
        } else {
            repository.add(dog: Dog(imageUrl: request.url))
        }
    }
}
