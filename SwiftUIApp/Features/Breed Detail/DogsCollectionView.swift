import SwiftUI
import Dogs

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
                dogsGrid()
            }
        }
    }

    private func dogsGrid() -> LazyVGrid<ForEach<[DisplayableDog], String, some View>> {
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

    private func dogImage(for displayableDog: DisplayableDog) -> DogImage {
        instanceProvider.resolve(DogImage.self, argument: displayableDog)
    }
}
