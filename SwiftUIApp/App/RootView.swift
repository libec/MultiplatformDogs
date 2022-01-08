import SwiftUI
import Dogs

struct RootView: View {

    private let breedView: BreedsView
    private let favoriteDogsView: BreedDetailView

    init(
        breedView: BreedsView,
        favoriteDogsView: BreedDetailView
    ) {
        self.breedView = breedView
        self.favoriteDogsView = favoriteDogsView
    }

    var body: some View {
        TabView {
            breedView
                .tabItem {
                    Image(systemName: "pawprint")
                }

            favoriteDogsView
                .tabItem {
                    Image(systemName: "heart")
                }
        }
    }
}

