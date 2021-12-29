//
//  BreedsDetailView.swift
//  SwiftUIApp
//
//  Created by Libor Huspenina on 29.12.2021.
//  Copyright © 2021 Example. All rights reserved.
//

import SwiftUI
import Combine
import Dogs

struct BreedsDetailView: View {

    let breedDetailViewModel: BreedDetailViewModel
    @State private var dogs: [DisplayableDog] = []

    init(breedDetailViewModel: BreedDetailViewModel) {
        self.breedDetailViewModel = breedDetailViewModel
    }

    private var dogsOutput: AnyPublisher<[DisplayableDog], Never> {
        breedDetailViewModel.output
            .receive(on: DispatchQueue.main, options: .none)
            .eraseToAnyPublisher()
    }

    var body: some View {
        DogsCollectionView(dogs: dogs)
        .onReceive(dogsOutput) { dogs in
            self.dogs = dogs
        }
    }
}

struct DogsCollectionView: View {

    var dogs: [DisplayableDog]

    var gridItems: [GridItem] {
        [GridItem(.flexible()), GridItem(.flexible())]
    }

    var body: some View {
        GeometryReader { reader in
            ScrollView {
                LazyVGrid(columns: gridItems, alignment: .center, spacing: 16) {
                    ForEach(dogs, id: \.imageUrl) { dog in
                        let size = reader.size.width / Double(gridItems.count) - 16
                        DogImage(imageUrl: dog.imageUrl)
                            .frame(
                                width: size,
                                height: size,
                                alignment: .center
                            )
                    }
                }
            }
        }
    }
}

struct DogImage: View {
    let imageUrl: String

    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }


    var dogImage: AnyPublisher<Data?, Never> {
        guard let url = URL(string: imageUrl) else {
            log("Invalid dog image URL")
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
        VStack {
            if let data = imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 4).shadow(radius: 10))
            } else {
                EmptyView()
            }
        }
        .onReceive(dogImage) { imageData in
            self.imageData = imageData
        }
    }
}

struct DogsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        DogsCollectionView(dogs: [
            DisplayableDog(imageUrl: "https://images.dog.ceo/breeds/affenpinscher/n02110627_11279.jpg"),
            DisplayableDog(imageUrl: "https://images.dog.ceo/breeds/newfoundland/n02111277_6616.jpg")
        ])
    }
}
