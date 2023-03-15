import SwiftUI

struct LaunchCreateView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var name: String = ""
    @State var notes: String = ""
    @State var isViewed = false
    @State var launchDate = Date()
    @State var launchpad: String = ""
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $name)
                    TextField("Launch Pad", text: $launchpad)
                    TextField("Notes", text: $notes)
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
                        dismiss()
                    } label: {
                        Text("Save")
                    }

                }
            }
        }
    }
}

struct LaunchCreateView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchCreateView()
    }
}
