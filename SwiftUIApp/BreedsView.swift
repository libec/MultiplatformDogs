//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Libor Huspenina on 28.12.2021.
//  Copyright © 2021 Cleverlance. All rights reserved.
//

import SwiftUI
import Combine
import Dogs

struct BreedsView: View {

    @State private var output: BreedsViewModelOutput = .init(displayableBreeds: [])
    let breedViewModel: BreedsViewModel
    let navigation: SwiftUINavigation

    init(breedViewModel: BreedsViewModel, navigation: SwiftUINavigation) {
        self.breedViewModel = breedViewModel
        self.navigation = navigation
    }

    var body: some View {
        content
        .onReceive(breedViewModel.output) { output in
            self.output = output
        }
    }

    var content: some View {
        NavigationView {
            List {
                ForEach(output.displayableBreeds, id: \.name) { breed in
                    Button(breed.name)
                        .foregroundColor(.black)
                }
            }
            .navigationTitle("Dogs")
            .modifier(navigation)
        }
    }
}

protocol BreedItemViewModel {
    func select()
    var output: AnyPublisher<String, Never> { get }
}

struct BreedCell: View {

    private let breedItemViewModel: BreedItemViewModel
    @State private var displayableBreed: DisplayableBreeds

    init(name: String, breedItemViewModel: BreedItemViewModel) {
        self.breedItemViewModel = breedItemViewModel
    }

    var body: some View {
        content.onReceive(breedItemViewModel.output) { breedName in
            self.name = breedName
        }
    }

    var content: some View {
        Button(name, action: breedItemViewModel.select)
    }
}
