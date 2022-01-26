import SwiftUI
import Dogs

struct BreedsView: View {

    @State private var output: [DisplayableBreed] = []
    let breedViewModel: BreedsViewModel

    var body: some View {
        content
        .onReceive(breedViewModel.output) { output in
            self.output = output
        }
    }

    var content: some View {
        ForEach(output, id: \.name) { breed in
            Button(breed.name) {
                breedViewModel.select(breed: breed.identifier)
            }
            .foregroundColor(.black)
        }
    }

}
