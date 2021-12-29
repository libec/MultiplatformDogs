import Combine
import SwiftUI
import Dogs

struct SwiftUINavigation: Coordinator, ViewModifier {

    @State private var shownBreedDetail: Bool = false
    private let instanceProvider: InstanceProvider
    private let querySelectedBreedUseCase: QuerySelectedBreedUseCase
    private var subscriptions = Set<AnyCancellable>()

    init(instanceProvider: InstanceProvider, querySelectedBreedUseCase: QuerySelectedBreedUseCase) {
        self.instanceProvider = instanceProvider
        self.querySelectedBreedUseCase = querySelectedBreedUseCase
    }

    func showBreedDetail() {

    }

    var showDetailPublisher: AnyPublisher<Breed?, Never> {
        querySelectedBreedUseCase.selectedBreed()
            .receive(on: DispatchQueue.main, options: .none)
            .eraseToAnyPublisher()
    }

    func body(content: Content) -> some View {
        content
        .background(NavigationLink(destination: instanceProvider.resolve(BreedsDetailView.self), isActive: $shownBreedDetail) { EmptyView() })
        .onReceive(showDetailPublisher) { selectedBreed in
            shownBreedDetail = selectedBreed != nil
        }
    }
}
