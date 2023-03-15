import SwiftUI

struct CirclularImageView: View {
    let color: Color
    var body: some View {
        Image(systemName: "list.bullet")
            .foregroundColor(.white)
            .padding(12)
            .background(color)
            .clipShape(Circle())
    }
}

struct CirclularImageView_Previews: PreviewProvider {
    static var previews: some View {
        CirclularImageView(color: .red)
    }
}
