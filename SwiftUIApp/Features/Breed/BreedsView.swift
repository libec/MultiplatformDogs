import SwiftUI
import Combine
import Dogs

struct BreedsView: View {

    @State private var output: [DisplayableBreed] = []
    private let viewModel: BreedsViewModel
    private let navigation: SwiftUINavigation

    init(viewModel: BreedsViewModel, navigation: SwiftUINavigation) {
        self.viewModel = viewModel
        self.navigation = navigation
    }

    private var breedsOutput: AnyPublisher<[DisplayableBreed], Never> {
        viewModel.output
            .receive(on: DispatchQueue.main, options: .none)
            .eraseToAnyPublisher()
    }

    var body: some View {
        content
            .onReceive(breedsOutput) { output in
                self.output = output
            }
            .onAppear {
                viewModel.fetchBreeds()
            }
    }

    var content: some View {
        NavigationView {
            List(output) { breed in
                Button(breed.name) {
                    viewModel.select(breed: breed.id)
                }
                .foregroundColor(.black)
            }
            .navigationTitle("Dogs")
            .modifier(navigation)
        }
    }
}
