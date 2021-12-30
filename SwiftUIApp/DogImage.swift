import SwiftUI
import Combine
import UIKitApp
import Dogs

struct DogImage: View {
    let imageUrl: String
    let imageResource: DogsImageResource

    init(imageUrl: String, imageResource: DogsImageResource) {
        self.imageUrl = imageUrl
        self.imageResource = imageResource
    }

    var dogImage: AnyPublisher<Data?, Never> {
        guard let url = URL(string: imageUrl) else {
            fatalError()
        }
        return imageResource
            .imageData(for: url)
            .receive(on: DispatchQueue.main, options: .none)
            .eraseToAnyPublisher()
    }

    @State private var imageData: Data? = nil

    var body: some View {
        withAnimation(Animation.easeIn(duration: 1)) {
            Group {
                if let data = imageData, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 4).shadow(radius: 10))
                } else {
                    ProgressView().progressViewStyle(.circular)
                        .frame(width: 50, height: 50, alignment: .center)
                }
            }
        }
        .onReceive(dogImage) { imageData in
            self.imageData = imageData
        }
    }
}
