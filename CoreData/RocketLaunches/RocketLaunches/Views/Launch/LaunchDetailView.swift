import SwiftUI

struct LaunchDetailView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    let launch: RocketLaunch
    let name: String
    let notes: String
    let date: Date
    let isViewed: Bool
    
    init(launch: RocketLaunch) {
        self.launch = launch
        name = launch.name
        notes = launch.notes ?? ""
        date = launch.launchDate ?? Date()
        isViewed = launch.isViewed
    }
    
    var body: some View {
        Form {
            Section("Notes") {
                Text(notes)
            }
            Section("Launch Date") {
                Text(date.formatted())
            }
            Section {
                Button("Mark as Viewed") {
                    launch.isViewed = true
                    do {
                        try viewContext.save()
                        dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        .navigationTitle(name)
        .background(Color(.systemBackground))
    }
}
//
//struct LaunchDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchDetailView()
//    }
//}
