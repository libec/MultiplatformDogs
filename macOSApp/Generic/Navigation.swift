import Combine
import Dogs

class Navigation: ObservableObject {

    private let querySelectedBreedUseCase: QuerySelectedBreedUseCase
    private var subscriptions = Set<AnyCancellable>()

    init(querySelectedBreedUseCase: QuerySelectedBreedUseCase) {
        self.querySelectedBreedUseCase = querySelectedBreedUseCase

        querySelectedBreedUseCase.selectedBreed()
            .sink { [weak self] breed in
                self?.showDogs = breed != nil
            }
            .store(in: &subscriptions)
    }

    @Published var showDogs: Bool = false
    @Published var showFavoriteDogs: Bool = false
}
