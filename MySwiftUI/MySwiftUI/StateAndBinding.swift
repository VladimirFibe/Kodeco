import SwiftUI

struct StateAndBinding: View {
    @State private var swiftyColor = Color.red
    @State private var swiftyOpacity = 0.7
    var body: some View {
        VStack {
            SwiftyControls(swiftyColor: $swiftyColor,
                           swiftyOpacity: $swiftyOpacity)
            
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .padding(25)
                .foregroundStyle(.white)
                .opacity(swiftyOpacity)
                .background(swiftyColor)
                .cornerRadius(50)
        }
        .padding()
    }
}

#Preview {
    StateAndBinding()
}


struct SwiftyControls: View {
    @Binding var swiftyColor: Color
    @Binding var swiftyOpacity: Double
    var body: some View {
        VStack {
            ColorPicker("Title", selection: $swiftyColor)
            Slider(value: $swiftyOpacity, in: 0...1)
                .tint(swiftyColor)
        }
    }
}
