import SwiftUI
import CoreData

struct ContentView: View {
    @State private var isShowingListModal = false
    var body: some View {
        NavigationStack {
            ListView()
                .navigationTitle("Launches")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isShowingListModal.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }

                    }
                }
        }
        .sheet(isPresented: $isShowingListModal) {
        ListCreateView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
