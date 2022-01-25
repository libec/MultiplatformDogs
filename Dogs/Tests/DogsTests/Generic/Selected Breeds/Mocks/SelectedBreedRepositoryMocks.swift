import Dogs
import Combine

class SelectedBreedRepositorySpy: SelectedBreedRepository {

    var inputSelectedBreed: Breed?
    var deselectCalled = false

    var selectedBreed: AnyPublisher<Breed?, Never> {
        Empty().eraseToAnyPublisher()
    }

    func select(breed: Breed) {
        self.inputSelectedBreed = breed
    }

    func deselect() {
        deselectCalled = true
    }
}

class SelectedBreedRepositoryStub: SelectedBreedRepository {
    var subject = CurrentValueSubject<Breed?, Never>(nil)

    var selectedBreed: AnyPublisher<Breed?, Never> {
        subject.eraseToAnyPublisher()
    }

    func select(breed: Breed) {
    }

    func deselect() {
    }
}
