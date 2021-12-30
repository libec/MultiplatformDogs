import SwiftUI
import Combine
import Dogs

struct BreedsDetailView: View {

    let breedDetailViewModel: BreedDetailViewModel
    @State private var dogs: [DisplayableDog] = []

    init(breedDetailViewModel: BreedDetailViewModel) {
        self.breedDetailViewModel = breedDetailViewModel
    }

    private var dogsOutput: AnyPublisher<[DisplayableDog], Never> {
        breedDetailViewModel.output
            .receive(on: DispatchQueue.main, options: .none)
            .eraseToAnyPublisher()
    }

    var body: some View {
        DogsCollectionView(dogs: dogs)
        .onReceive(dogsOutput) { dogs in
            self.dogs = dogs
        }
    }
}

struct DogsCollectionView: View {

    var dogs: [DisplayableDog]

    var gridItems: [GridItem] {
        [GridItem(.flexible()), GridItem(.flexible())]
    }

    var body: some View {
        GeometryReader { reader in
            ScrollView {
                LazyVGrid(columns: gridItems, alignment: .center, spacing: 16) {
                    ForEach(dogs, id: \.imageUrl) { dog in
                        let size = reader.size.width / Double(gridItems.count) - 16
                        DogImage(imageUrl: dog.imageUrl)
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
}

struct DogsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        DogsCollectionView(dogs: [
            DisplayableDog(imageUrl: "https://images.dog.ceo/breeds/affenpinscher/n02110627_11279.jpg"),
            DisplayableDog(imageUrl: "https://images.dog.ceo/breeds/newfoundland/n02111277_6616.jpg")
        ])
    }
}
