import SwiftUI
import Combine
import Dogs

struct DogImage: View {

    let dog: DisplayableDog
    let imageResource: DogsImageResource
    let viewModel: DogViewModel

    @State private var imageData: Data? = nil

    init(dog: DisplayableDog, viewModel: DogViewModel, imageResource: DogsImageResource) {
        self.dog = dog
        self.viewModel = viewModel
        self.imageResource = imageResource
    }

    var dogImage: AnyPublisher<Data?, Never> {
        guard let url = URL(string: dog.imageUrl) else {
            fatalError()
        }

        return imageResource
            .imageData(for: url)
            .receive(on: DispatchQueue.main, options: .none)
            .eraseToAnyPublisher()
    }

    var body: some View {
        Group {
            if let data = imageData, let uiImage = UIImage(data: data) {
                ZStack {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 4).shadow(radius: 10))
                    Image(systemName: dog.favorite ? "heart.fill" : "heart")
                        .renderingMode(.original)
                        .font(.largeTitle)
                        .onTapGesture {
                            viewModel.toggleFavorite()
                        }

                }
            } else {
                ProgressView().progressViewStyle(.circular)
                    .frame(width: 50, height: 50, alignment: .center)
            }
        }
        .onReceive(dogImage) { imageData in
            self.imageData = imageData
        }
    }
}
