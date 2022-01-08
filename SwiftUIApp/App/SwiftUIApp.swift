import SwiftUI
import Dogs

@main
struct SwiftUIApp: App {

    let appStart = AppStart()

    var body: some Scene {
        WindowGroup {
            let view: BreedsView = appStart.startApp()
            view
        }
    }
}
