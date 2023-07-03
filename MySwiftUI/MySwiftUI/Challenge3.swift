import SwiftUI

enum Mood: String, CaseIterable, Identifiable {
  case happy = "😀"
  case sad = "☹️"
  case upsidedown = "🙃"
  case cat = "🐱"
    var id: Mood { self }
}

struct Challenge3: View {
    
    // MARK: TODO - These 3 properties will need an attribute added...
    @State private var name = ""
    @State private var favoriteColor: Color = .green
    @State private var mood: Mood = .happy
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Set your status:")
            
            StatusControl(name: $name, favoriteColor: $favoriteColor, mood: $mood)
            
            StatusIcon(name: name, favoriteColor: favoriteColor, mood: mood)
        }
        .padding()
    }
}

struct StatusControl: View {
    @Binding var name: String
    @Binding var favoriteColor: Color
    @Binding var mood: Mood
    
    var body: some View {
        VStack(spacing: 30.0) {
            TextField("Name", text: $name)
                .textFieldStyle(.roundedBorder)
            
            ColorPicker("Favorite Color", selection: $favoriteColor)
            
            Picker("Mood", selection: $mood) {
                ForEach(Mood.allCases) { Text($0.rawValue).tag($0)}
            }
            .pickerStyle(.segmented)
        }
    }
}

struct StatusIcon: View {
  let name: String
  let favoriteColor: Color
  let mood: Mood
  
  var body: some View {
    VStack {
      Text(mood.rawValue)
      Text(name)
        .foregroundStyle(.white)
    }
    .font(.largeTitle)
    .padding()
    .background(favoriteColor)
    .cornerRadius(12)
  }
}

#Preview {
    Challenge3()
}
