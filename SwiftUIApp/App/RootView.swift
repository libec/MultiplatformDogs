import SwiftUI
import Dogs

struct RootView: View {

    private let breedView: BreedsView

    init(breedView: BreedsView) {
        self.breedView = breedView
    }

    var body: some View {
        TabView {
            breedView
                .tabItem {
                    Image(systemName: "pawprint")
                }

            Text("Favorite dogs up in this tab")
                .tabItem {
                    Image(systemName: "heart")
                }
        }
    }
}

