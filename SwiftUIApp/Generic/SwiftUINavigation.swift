import Combine
import SwiftUI
import Dogs

struct SwiftUINavigation: ViewModifier {

    @State private var showDogsList: Bool = false
    private let instanceProvider: InstanceProvider
    private let navigation: Navigation
    private var subscriptions = Set<AnyCancellable>()

    init(
        instanceProvider: InstanceProvider,
        navigation: Navigation
    ) {
        self.instanceProvider = instanceProvider
        self.navigation = navigation
    }

    private var showDogsPublisher: AnyPublisher<Bool, Never> {
        navigation.showDogs
            .receive(on: DispatchQueue.main, options: .none)
            .eraseToAnyPublisher()
    }

    func body(content: Content) -> some View {
        content
            .background(NavigationLink(destination: instanceProvider.resolve(DogsView.self, argument: DogsDisplayStrategy.specificBreed), isActive: $showDogsList) { EmptyView() })
        .onReceive(showDogsPublisher) { showDogs in
            showDogsList = showDogs
        }
    }
}
