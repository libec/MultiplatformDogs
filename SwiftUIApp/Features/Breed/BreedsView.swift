import SwiftUI
import Combine
import Dogs

struct BreedsView: View {

    @State private var output: [DisplayableBreed] = []
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
            List(output, id: \.name) { breed in
                Button(breed.name) {
                    breedViewModel.select(breed: breed.identifier)
                }
                .foregroundColor(.black)
            }
            .navigationTitle("Dogs")
            .modifier(navigation)
        }
    }
}
