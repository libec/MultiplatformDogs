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

struct ContentView: View {

    private let breedViewModel: BreedsViewModel
    @State private var output: BreedsViewModelOutput = .init(displayableBreeds: [])

    init(breedViewModel: BreedsViewModel) {
        self.breedViewModel = breedViewModel
    }

    var body: some View {
        List {
            ForEach(output.displayableBreeds, id: \.name) { breed in
                Text(breed.name)
            }
        }
        .onReceive(breedViewModel.output) { output in
            self.output = output
        }
        .onAppear {
            breedViewModel.fetch()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    struct BreedsViewModelDummy: BreedsViewModel {
        var output: AnyPublisher<BreedsViewModelOutput, Never> {
            return Just(BreedsViewModelOutput(displayableBreeds: [])).eraseToAnyPublisher()
        }

        func fetch() { }
    }

    static var previews: some View {
        ContentView(breedViewModel: BreedsViewModelDummy())
    }
}
