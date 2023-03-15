import SwiftUI

struct ListCreateView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    @State private var text = ""
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                CirclularImageView(color: .red)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical)
                Text("Enter a list title")
                    .padding(.horizontal)
                TextField("Title", text: $text)
                    .padding()
                    .background(Color(red: 231 / 255, green: 234 / 255.0, blue: 237 / 255.0))
                    .cornerRadius(10)
                    .padding()
                Spacer()
            }
            .navigationTitle("Create Launch")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        RocketLaunchList.create(withName: text, in: viewContext)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ListCreateView_Previews: PreviewProvider {
    static var previews: some View {
        ListCreateView()
    }
}
