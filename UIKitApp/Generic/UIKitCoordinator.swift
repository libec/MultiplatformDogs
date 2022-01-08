import UIKit
import Dogs
import Combine

final class UIKitCoordinator: Coordinator {

    let window: UIWindow
    let instanceProvider: InstanceProvider

    private var subscriptions = Set<AnyCancellable>()

    init(
        window: UIWindow,
        instanceProvider: InstanceProvider,
        querySelectedBreedUseCase: QuerySelectedBreedUseCase
    ) {
        self.window = window
        self.instanceProvider = instanceProvider

        querySelectedBreedUseCase.selectedBreed()
            .receive(on: DispatchQueue.main, options: .none)
            .sink { [weak self] breed in
                guard let unwrappedSelf = self else { return }
                if breed == nil {
                    unwrappedSelf.hideBreedDetail()
                } else {
                    unwrappedSelf.showBreedDetail()
                }
            }
            .store(in: &subscriptions)
    }

    func showBreedDetail() {
        let viewController = instanceProvider.resolve(BreedsDetailViewController.self)
        navigationController?.pushViewController(viewController, animated: true)
    }

    func hideBreedDetail() {
        navigationController?.popViewController(animated: true)
    }

    private var navigationController: UINavigationController? {
        window.rootViewController as? UINavigationController
    }
}
