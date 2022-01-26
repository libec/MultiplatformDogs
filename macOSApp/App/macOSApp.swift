import SwiftUI

@main
struct macOSAppApp: App {
    
    let appStart = AppStart()

    var body: some Scene {
        WindowGroup {
            rootView
        }
    }

    var rootView: RootView {
        appStart.startApp()
    }
}
