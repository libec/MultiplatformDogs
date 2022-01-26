import AppKit
import SwiftUI
import Combine
import Dogs

struct DogImage: View {

    let dog: DisplayableDog
    let imageResource: DogsImageResource
    let viewModel: DogViewModel

    @State private var imageData: Data? = nil

    init(
        dog: DisplayableDog,
        viewModel: DogViewModel,
        imageResource: DogsImageResource
    ) {
        self.dog = dog
        self.viewModel = viewModel
        self.imageResource = imageResource
    }

    func dogImage() async -> Data? {
        guard let url = URL(string: dog.imageUrl) else {
            fatalError()
        }

        return try? await imageResource.imageData(for: url)
    }

    var body: some View {
        Group {
            if let data = imageData, let nsImage = NSImage(data: data) {
                ZStack(alignment: .topTrailing) {
                    Image(nsImage: nsImage)
                        .resizable()
                        .clipped()
                    ZStack {
                        Color.white.opacity(0.5)
                        heartButton
                    }
                    .cornerRadius(5)
                    .frame(width: 50, height: 50)
                }
            } else {
                ProgressView()
            }
        }.task {
            self.imageData = await dogImage()
        }
    }

    private var heartButton: some View {
        Image(systemName: dog.favorite ? "heart.fill" : "heart")
            .renderingMode(.original)
            .font(.largeTitle)
            .onTapGesture {
                viewModel.toggleFavorite()
            }
    }
}
