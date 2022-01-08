import SwiftUI
import Combine
import Dogs

struct BreedDetailView: View {

    private let breedDetailViewModel: BreedDetailViewModel
    private let instanceProvider: InstanceProvider

    @State private var dogs: [DisplayableDog] = []

    init(breedDetailViewModel: BreedDetailViewModel, instanceProvider: InstanceProvider) {
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

struct DogsCollectionView: View {

    var dogs: [DisplayableDog]
    private let instanceProvider: InstanceProvider

    init(dogs: [DisplayableDog], instanceProvider: InstanceProvider) {
        self.dogs = dogs
        self.instanceProvider = instanceProvider
    }

    var gridItems: [GridItem] {
        [GridItem(.flexible()), GridItem(.flexible())]
    }

    var body: some View {
        GeometryReader { reader in
            ScrollView {
                LazyVGrid(columns: gridItems, alignment: .center, spacing: 16) {
                    ForEach(dogs, id: \.imageUrl) { dog in
                        let size = reader.size.width / Double(gridItems.count) - 16
                        dogImage(for: dog)
                            .frame(
                                width: size,
                                height: size,
                                alignment: .center
                            )
                    }
                }
            }
        }
    }

    private func dogImage(for displayableDog: DisplayableDog) -> DogImage {
        instanceProvider.resolve(DogImage.self, argument: displayableDog)
    }
}
