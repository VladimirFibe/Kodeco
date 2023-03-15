import SwiftUI

@main
struct RocketLaunchesApp: App {
    let persistentCotroller = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentCotroller.container.viewContext)
        }
    }
}
