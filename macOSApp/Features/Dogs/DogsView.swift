import SwiftUI
import Combine
import Dogs

struct DogsView: View {

    private let viewModel: DogsViewModel
    private let instanceProvider: InstanceProvider

    @State private var dogs: [DisplayableDog] = []

    init(
        viewModel: DogsViewModel,
        instanceProvider: InstanceProvider
    ) {
        self.viewModel = viewModel
        self.instanceProvider = instanceProvider
    }

    private var dogsOutput: AnyPublisher<[DisplayableDog], Never> {
        viewModel.output
            .receive(on: DispatchQueue.main, options: .none)
            .eraseToAnyPublisher()
    }

    var body: some View {
        DogsGrid(dogs: dogs, instanceProvider: instanceProvider)
            .onReceive(dogsOutput) { dogs in
                self.dogs = dogs
            }
    }
}
