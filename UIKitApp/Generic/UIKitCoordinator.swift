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
        let viewController = instanceProvider.resolve(BreedsDetailViewController.self, argument: BreedDetailDisplayStrategy.specificBreed)
        breedsNavigationController?.pushViewController(viewController, animated: true)
    }

    func hideBreedDetail() {
        breedsNavigationController?.popViewController(animated: true)
    }

    private var tabBarController: RootViewController? {
        window.rootViewController as? RootViewController
    }

    private var breedsNavigationController: UINavigationController? {
        tabBarController?.viewControllers?.first as? UINavigationController
    }
}
