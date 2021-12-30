import SwiftUI
import Combine
import Dogs

struct BreedsDetailView: View {

    private let breedDetailViewModel: BreedDetailViewModel
    private let imageResource: DogsImageResource

    @State private var dogs: [DisplayableDog] = []

    init(breedDetailViewModel: BreedDetailViewModel, imageResource: DogsImageResource) {
        self.breedDetailViewModel = breedDetailViewModel
        self.imageResource = imageResource
    }

    private var dogsOutput: AnyPublisher<[DisplayableDog], Never> {
        breedDetailViewModel.output
            .receive(on: DispatchQueue.main, options: .none)
            .eraseToAnyPublisher()
    }

    var body: some View {
        DogsCollectionView(dogs: dogs, imageResource: imageResource)
        .onReceive(dogsOutput) { dogs in
            self.dogs = dogs
        }
    }
}

struct DogsCollectionView: View {

    var dogs: [DisplayableDog]

    private let imageResource: DogsImageResource

    init(dogs: [DisplayableDog], imageResource: DogsImageResource) {
        self.dogs = dogs
        self.imageResource = imageResource
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
                        DogImage(dog: dog, imageResource: imageResource)
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
            DisplayableDog(dogID: "dog", imageUrl: "https://images.dog.ceo/breeds/affenpinscher/n02110627_11279.jpg", favorite: false),
            DisplayableDog(dogID: "secondDog", imageUrl: "https://images.dog.ceo/breeds/newfoundland/n02111277_6616.jpg", favorite: true)
        ], imageResource: DogsImageCachedResource())
    }
}
