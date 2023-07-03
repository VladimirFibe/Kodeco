import SwiftUI

struct Challenge1: View {
    var body: some View {
        Image("monster")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .shadow(radius: 15)
            .border(Color.green, width: 5)
            .padding()
    }
}

#Preview {
    Challenge1()
}
