import SwiftUI
import Dogs

struct DogsGridView: View {

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
                dogsGrid(size: reader.size)
            }
        }
    }

    private func dogsGrid(size: CGSize) -> some View {
        LazyVGrid(columns: gridItems, alignment: .center, spacing: 0) {
            ForEach(dogs, id: \.imageUrl) { dog in
                dogImage(for: dog)
                    .aspectRatio(1, contentMode: .fill)
                    .cornerRadius(10)
                    .padding(5)

            }
        }
    }

    private func dogImage(for displayableDog: DisplayableDog) -> DogImage {
        instanceProvider.resolve(DogImage.self, argument: displayableDog)
    }
}
