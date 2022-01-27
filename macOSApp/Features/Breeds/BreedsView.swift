import SwiftUI
import Dogs

struct BreedsView: View {

    @State private var breeds: [DisplayableBreed] = []
    let breedViewModel: BreedsViewModel

    var body: some View {
        BreedList(breeds: breeds) { breed in
            breedViewModel.select(breed: breed.identifier)
        }
        .onReceive(breedViewModel.output) { breeds in
            self.breeds = breeds
        }
    }
}

struct BreedList: View {

    private let breeds: [DisplayableBreed]
    private let onTapGesture: (DisplayableBreed) -> Void

    init(breeds: [DisplayableBreed], onTapGesture: @escaping (DisplayableBreed) -> Void) {
        self.breeds = breeds
        self.onTapGesture = onTapGesture
    }

    var body: some View {
        VStack(spacing: 0) {
            ForEach(breeds.indices, id: \.self) { index in
                HStack {
                    Text(breeds[index].name)
                        .font(Font.title)
                        .foregroundColor(.black)
                        .frame(minHeight: 30, idealHeight: 40, maxHeight: 50)
                        .padding()
                    Spacer()
                }
                .background(index % 2 == 0 ? Color.gray : Color.white)
                .onTapGesture {
                    onTapGesture(breeds[index])
                }
            }
        }
    }
}

struct BreedList_Previews: PreviewProvider {
    static var previews: some View {
        BreedList(
            breeds: [
                DisplayableBreed(identifier: "1", name: "Dachshund"),
                DisplayableBreed(identifier: "2", name: "Dalmatian"),
                DisplayableBreed(identifier: "3", name: "Dane"),
                DisplayableBreed(identifier: "4", name: "Frise"),
                DisplayableBreed(identifier: "5", name: "Mix"),
            ],
            onTapGesture: { _ in }
        )
    }
}
