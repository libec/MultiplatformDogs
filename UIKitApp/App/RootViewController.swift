import UIKit

class RootViewController: UITabBarController {

    init(breedsViewController: BreedsViewController, favoriteDogsViewController: BreedsDetailViewController) {
        super.init(nibName: nil, bundle: nil)
        let breedsNavigationViewController = UINavigationController(rootViewController: breedsViewController)
        breedsViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "pawprint"), selectedImage: UIImage(systemName: "pawprint.fill"))
        let favoritesNavigationViewController = UINavigationController(rootViewController: favoriteDogsViewController)
        favoritesNavigationViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        self.viewControllers = [breedsNavigationViewController, favoritesNavigationViewController]
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}
