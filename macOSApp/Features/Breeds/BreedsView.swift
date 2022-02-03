import SwiftUI
import Dogs
import Combine

struct BreedsView: View {

    @State private var breeds: [DisplayableBreed] = []
    let viewModel: BreedsViewModel

    private var breedsOutput: AnyPublisher<[DisplayableBreed], Never> {
        viewModel.output
            .receive(on: DispatchQueue.main, options: .none)
            .eraseToAnyPublisher()
    }

    var body: some View {
        BreedList(breeds: breeds) { breed in
            viewModel.select(breed: breed.id)
        }
        .onReceive(breedsOutput) { breeds in
            self.breeds = breeds
        }
        .onAppear {
            viewModel.fetchBreeds()
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
        List(breeds) { breed in
            Text(breed.name)
                .font(Font.largeTitle)
                .foregroundColor(.accentColor)
                .frame(minHeight: 30, idealHeight: 40, maxHeight: 50)
                .padding()
                .onTapGesture {
                    onTapGesture(breed)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button {
                        print("Like all dogs from category")
                    } label: {
                        Label("Like", systemImage: "heart")
                    }

                }
        }
        .listStyle(.inset(alternatesRowBackgrounds: true))
    }
}

struct BreedList_Previews: PreviewProvider {
    static var previews: some View {
        BreedList(
            breeds: [
                DisplayableBreed(id: "1", name: "Dachshund"),
                DisplayableBreed(id: "2", name: "Dalmatian"),
                DisplayableBreed(id: "3", name: "Dane"),
                DisplayableBreed(id: "4", name: "Frise"),
                DisplayableBreed(id: "5", name: "Mix"),
            ],
            onTapGesture: { _ in }
        )
    }
}
