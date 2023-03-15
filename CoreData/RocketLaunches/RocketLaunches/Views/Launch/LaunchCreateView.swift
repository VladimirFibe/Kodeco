import SwiftUI
import CoreData

struct LaunchCreateView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var viewContext
    
    @State var name: String = ""
    @State var notes: String = ""
    @State var isViewed = false
    @State var launchDate = Date()
    @State var launchpad = ""
    @State var tag = ""
    let list: RocketLaunchList

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $name)
                    TextField("Launch Pad", text: $launchpad)
                    TextField("Notes", text: $notes)
                }
                Section {
                    TextField("Tag", text: $tag)
                }
                Section {
                    DatePicker(selection: $launchDate, displayedComponents: .date) {
                        Text("Date")
                    }
                }
            }
            .background(Color(.systemBackground))
            .navigationTitle(Text("Create Event"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let tags = Set(tag.split(separator: ", ").map {
                            RocketLaunchTag.fethOrCreate(withName: String($0), in: viewContext)
                        })
                        print(tags)
                        RocketLaunch.createWith(name: name,
                                                notes: notes,
                                                launchDate: launchDate,
                                                isViewed: isViewed,
                                                launchpad: launchpad,
                                                in: list,
                                                with: tags,
                                                using: viewContext)
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
    
}
//
//struct LaunchCreateView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchCreateView()
//    }
//}
