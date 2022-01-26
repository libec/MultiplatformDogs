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
            HStack {
                Text(breed.name)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "arrow.right.circle")
            }
            .frame(minHeight: 30, idealHeight: 40, maxHeight: 50)
            .onTapGesture {
                breedViewModel.select(breed: breed.identifier)
            }
        }
    }

}
