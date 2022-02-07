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
        AsyncImage(url: URL(string: dog.imageUrl)) { image in
            ZStack(alignment: .topTrailing) {
                image.resizable()
                ZStack {
                    Color.white.opacity(0.5)
                    heartButton
                }
                .frame(width: 50, height: 50)
                .cornerRadius(5)
            }
        } placeholder: {
            ProgressView()
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
