import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appStart = AppStart()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let breedsViewController: BreedsViewController = appStart.startApp()
        let navigationController = UINavigationController(rootViewController: breedsViewController)
        window?.rootViewController = navigationController
        return true
    }
}
