//
//  BreedsDetailView.swift
//  SwiftUIApp
//
//  Created by Libor Huspenina on 29.12.2021.
//  Copyright © 2021 Example. All rights reserved.
//

import SwiftUI

struct BreedsDetailView: View {
    var body: some View {
        let dogs: [String] = Array(0...1500).map { _ in
            "\(Double.random(in: 0...100_000))"
        }
        DogsCollectionView(dogs: dogs)
    }
}

struct DogsCollectionView: View {

    var dogs: [String]

    var gridItems: [GridItem] {
        [GridItem(.flexible()), GridItem(.flexible())]
    }

    var body: some View {
        GeometryReader { reader in
            ScrollView {
                LazyVGrid(columns: gridItems, alignment: .center, spacing: 16) {
                    ForEach(dogs, id: \.self) { _ in
                        Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
                            .frame(width: reader.size.width / 2 - 16, height: reader.size.width / 2 - 16)
                    }
                }
            }
        }
    }
}

struct DogsCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        let dogs: [String] = Array(0...15).map { _ in
            "\(Double.random(in: 0...100_000))"
        }
        DogsCollectionView(dogs: dogs)
    }
}
