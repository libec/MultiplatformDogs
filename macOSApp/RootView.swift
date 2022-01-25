import SwiftUI
import Dogs

struct RootView: View {

    init() { }

    var body: some View {
        NavigationView {
            Text("Switch between dogs and favorites")
                .frame(minWidth: 300)
            Text("See detail")
        }
    }
}
