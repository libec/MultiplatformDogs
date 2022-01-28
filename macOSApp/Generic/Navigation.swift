import Combine
import Dogs

class Navigation: ObservableObject {

    private let navigation: Dogs.Navigation
    private var subscriptions = Set<AnyCancellable>()

    init(navigation: Dogs.Navigation) {
        self.navigation = navigation

        navigation.showDogs
            .sink { [weak self] showDogs in
                self?.showDogs = showDogs
            }
            .store(in: &subscriptions)
    }

    @Published var showDogs: Bool = false
    @Published var showFavoriteDogs: Bool = false
}
