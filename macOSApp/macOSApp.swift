import SwiftUI

@main
struct macOSAppApp: App {
    
    let appStart = AppStart()

    var body: some Scene {
        WindowGroup {
            let view: RootView = appStart.startApp()
            view
        }
    }
}
