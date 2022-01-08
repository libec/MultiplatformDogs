import SwiftUI
import Combine
import Dogs

struct BreedDetailView: View {

    private let breedDetailViewModel: BreedDetailViewModel
    private let instanceProvider: InstanceProvider

    @State private var dogs: [DisplayableDog] = []

    init(
        breedDetailViewModel: BreedDetailViewModel,
        instanceProvider: InstanceProvider
    ) {
        self.breedDetailViewModel = breedDetailViewModel
        self.instanceProvider = instanceProvider
    }

    private var dogsOutput: AnyPublisher<[DisplayableDog], Never> {
        breedDetailViewModel.output
            .receive(on: DispatchQueue.main, options: .none)
            .eraseToAnyPublisher()
    }

    var body: some View {
        DogsCollectionView(dogs: dogs, instanceProvider: instanceProvider)
            .onReceive(dogsOutput) { dogs in
                self.dogs = dogs
            }
    }
}
