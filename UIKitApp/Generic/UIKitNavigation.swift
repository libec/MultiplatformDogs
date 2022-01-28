import UIKit
import Dogs
import Combine

final class UIKitNavigation {

    let window: UIWindow
    let instanceProvider: InstanceProvider
    let navigation: Navigation

    private var subscriptions = Set<AnyCancellable>()

    init(
        window: UIWindow,
        instanceProvider: InstanceProvider,
        navigation: Navigation
    ) {
        self.window = window
        self.instanceProvider = instanceProvider
        self.navigation = navigation

        navigation.showDogs
            .receive(on: DispatchQueue.main, options: .none)
            .sink { [weak self] showDogs in
                guard let unwrappedSelf = self else { return }
                if showDogs {
                    unwrappedSelf.showDogs()
                } else {
                    unwrappedSelf.hideDogs()
                }
            }
            .store(in: &subscriptions)
    }

    func showDogs() {
        let viewController = instanceProvider.resolve(DogsViewController.self, argument: DogsDisplayStrategy.specificBreed)
        breedsNavigationController?.pushViewController(viewController, animated: true)
    }

    func hideDogs() {
        breedsNavigationController?.popViewController(animated: true)
    }

    private var tabBarController: RootViewController? {
        window.rootViewController as? RootViewController
    }

    private var breedsNavigationController: UINavigationController? {
        tabBarController?.viewControllers?.first as? UINavigationController
    }
}
