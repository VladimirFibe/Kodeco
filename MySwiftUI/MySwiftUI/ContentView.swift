import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "swift")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
                .background(Color.orange)
            Text("Hello, Vladimir!")
                .fontWeight(.black)
        }
    }
}

#Preview {
    ContentView()
}
