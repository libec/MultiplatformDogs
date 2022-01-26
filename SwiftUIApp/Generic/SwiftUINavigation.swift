import Combine
import SwiftUI
import Dogs

struct SwiftUINavigation: ViewModifier {

    @State private var showDogsList: Bool = false
    private let instanceProvider: InstanceProvider
    private let querySelectedBreedUseCase: QuerySelectedBreedUseCase
    private var subscriptions = Set<AnyCancellable>()

    init(instanceProvider: InstanceProvider, querySelectedBreedUseCase: QuerySelectedBreedUseCase) {
        self.instanceProvider = instanceProvider
        self.querySelectedBreedUseCase = querySelectedBreedUseCase
    }

    func showDogs() {

    }

    private var showDogsPublisher: AnyPublisher<Breed?, Never> {
        querySelectedBreedUseCase.selectedBreed()
            .receive(on: DispatchQueue.main, options: .none)
            .eraseToAnyPublisher()
    }

    func body(content: Content) -> some View {
        content
            .background(NavigationLink(destination: instanceProvider.resolve(DogsView.self, argument: DogsDisplayStrategy.specificBreed), isActive: $showDogsList) { EmptyView() })
        .onReceive(showDogsPublisher) { selectedBreed in
            showDogsList = selectedBreed != nil
        }
    }
}
