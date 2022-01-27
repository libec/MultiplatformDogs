import SwiftUI
import Combine
import Dogs

struct DogsView: View {

    private let viewModel: DogsViewModel
    private let instanceProvider: InstanceProvider

    @State private var dogs: [DisplayableDog] = []

    init(
        DogsViewModel: DogsViewModel,
        instanceProvider: InstanceProvider
    ) {
        self.viewModel = DogsViewModel
        self.instanceProvider = instanceProvider
    }

    private var dogsOutput: AnyPublisher<[DisplayableDog], Never> {
        viewModel.output
            .receive(on: DispatchQueue.main, options: .none)
            .eraseToAnyPublisher()
    }

    var body: some View {
        DogsGridView(dogs: dogs, instanceProvider: instanceProvider)
            .onReceive(dogsOutput) { dogs in
                self.dogs = dogs
            }
    }
}
