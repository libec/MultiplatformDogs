import SwiftUI
import Dogs

struct DogsGrid: View {

    private let dogs: [DisplayableDog]
    private let instanceProvider: InstanceProvider

    init(
        dogs: [DisplayableDog],
        instanceProvider: InstanceProvider
    ) {
        self.dogs = dogs
        self.instanceProvider = instanceProvider
    }

    private func gridItems(for size: CGSize) -> [GridItem] {
        let columnWidth = 200
        return Array<GridItem>.init(repeating: .init(.flexible(maximum: CGFloat(columnWidth))), count: Int(size.width) / columnWidth)
    }

    var body: some View {
        GeometryReader { reader in
            ScrollView(.vertical) {
                LazyVGrid(columns: gridItems(for: reader.size), spacing: 0) {
                    ForEach(dogs, id: \.imageUrl) { dog in
                        instanceProvider.resolve(DogImage.self, argument: dog)
                            .aspectRatio(1, contentMode: .fill)
                            .cornerRadius(15)
                            .padding(5)
                    }
                }
            }
        }
    }
}
