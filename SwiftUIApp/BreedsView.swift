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
                    Button(breed.name, action: breed.selection)
                        .foregroundColor(.black)
                }
            }
            .navigationTitle("Dogs")
            .modifier(navigation)
        }
        .onAppear {
            breedViewModel.fetch()
        }
    }
}
