import SwiftUI

struct LaunchesView: View {
    @State private var isShowingCreateModal = false
    var body: some View {
        VStack {
            List {
                Section {
                    ForEach(0 ..< 10) { _ in
                        Text("Hello, World!")
                    }
                }
            }
            .background(Color.white)
            NewLaunchButton(isShowingCreateModal: $isShowingCreateModal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
        }
        .navigationTitle("Launches")
        .sheet(isPresented: $isShowingCreateModal) {
            LaunchCreateView()
        }
    }
}

struct LaunchesView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchesView()
    }
}
