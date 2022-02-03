import AppKit
import SwiftUI
import Combine
import Dogs

struct DogImage: View {

    let dog: DisplayableDog
    let viewModel: DogViewModel

    init(
        dog: DisplayableDog,
        viewModel: DogViewModel
    ) {
        self.dog = dog
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: URL(string: dog.imageUrl)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }

            ZStack {
                Color.white.opacity(0.5)
                heartButton
            }
            .cornerRadius(5)
            .frame(width: 50, height: 50)
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
