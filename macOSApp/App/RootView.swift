import SwiftUI
import Dogs

struct RootView: View {

    private let breedsView: BreedsView
    private let dogsView: DogsView
    private let favoriteDogs: DogsView
    @ObservedObject private var navigation: Navigation

    init(
        breedsView: BreedsView,
        dogsView: DogsView,
        favoriteDogs: DogsView,
        navigation: Navigation
    ) {
        self.breedsView = breedsView
        self.dogsView = dogsView
        self.favoriteDogs = favoriteDogs
        self.navigation = navigation
    }

    var body: some View {
        NavigationView {
            sidebar
                .frame(minWidth: 150, maxWidth: 300)
            HStack(alignment: .center) {
                mainView
                if navigation.showFavoriteDogs {
                    favoriteView
                }
            }
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.status) {
                    Image(systemName: navigation.showFavoriteDogs ? "heart.fill" : "heart")
                        .onTapGesture {
                            navigation.showFavoriteDogs = !navigation.showFavoriteDogs
                        }
                }
            }
        }

        .frame(maxWidth: 1200, maxHeight: 900)
    }

    var sidebar: some View {
        breedsView
    }

    var mainView: some View {
        Group {
            if navigation.showDogs {
                dogsView
            } else {
                emptyView
            }
        }
    }

    var favoriteView: some View {
        favoriteDogs
    }

    var emptyView: Text {
        Text("No breed is selected!")
    }
}
