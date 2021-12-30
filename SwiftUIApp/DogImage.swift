import SwiftUI
import Combine

struct DogImage: View {
    let imageUrl: String

    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }


    var dogImage: AnyPublisher<Data?, Never> {
        guard let url = URL(string: imageUrl) else {
            fatalError()
        }
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .replaceError(with: nil)
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
