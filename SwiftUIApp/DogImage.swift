import SwiftUI
import Combine
import Dogs

struct DogImage: View {

    let dog: DisplayableDog
    let imageResource: DogsImageResource

    @State private var imageData: Data? = nil

    init(dog: DisplayableDog, imageResource: DogsImageResource) {
        self.dog = dog
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
                            print("Tapped dog: \(dog.imageUrl)")
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

struct DogImage_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 4) {
        DogImage(dog: DisplayableDog(
            imageUrl: "https://images.dog.ceo/breeds/affenpinscher/n02110627_11279.jpg",
            favorite: true
        ), imageResource: DogsImageCachedResource()
        )

        DogImage(dog: DisplayableDog(
            imageUrl: "https://images.dog.ceo/breeds/affenpinscher/n02110627_11279.jpg",
            favorite: false
        ), imageResource: DogsImageCachedResource()
        )
        }.frame(width: 200, height: 200, alignment: .center)
    }
}
