import SwiftUI

struct NewLaunchButton: View {
    @Binding var isShowingCreateModal: Bool
    var body: some View {
        Button {
            isShowingCreateModal.toggle()
        } label: {
            Label("New Launch", systemImage: "plus.circle.fill")
                .foregroundColor(.red)
        }
    }
}

struct NewLaunchButton_Previews: PreviewProvider {
    static var previews: some View {
        NewLaunchButton(isShowingCreateModal: .constant(true))
    }
}
