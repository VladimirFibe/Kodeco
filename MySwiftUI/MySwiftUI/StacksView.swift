import SwiftUI

struct MeowMixHeader: View {
    var body: some View {
        HStack(alignment: .bottom, spacing: 20.0) {
            Thumbnail()
            VStack(alignment: .leading) {
                description
                buttons
            }
        }
        .padding()
        .frame(minHeight: 150, maxHeight: 250)
    }
    
    var description: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading) {
                Text("Meow! Mix")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Apple Music for Luna")
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundStyle(Color.accentColor)
                Text("Updated Caturday")
                    .font(Font.system(.body).smallCaps())
            }
            Text("Whether you're a kitten or an old-timer, get meowing with this purrsonalized mix of music to meow to!")
            
            
        }
    }
    
    var buttons: some View {
        HStack(spacing: 12.0) {
            MyButton(title: "Play", icon: "play.fill") {}
            MyButton(title: "Shuffle!", icon: "shuffle") {}
        }
    }
}

struct MyButton: View {
    let title: String
    let icon: String
    let action: () -> ()
    var body: some View {
        Button(action: action) {
            Label(title, systemImage: icon)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(12)
        }
    }
}

struct Thumbnail: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.orange)
                    .aspectRatio(contentMode: .fit)
                    .shadow(radius: 10)
                Image(systemName: "play.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.white)
                    .opacity(0.8)
            }
            VStack(alignment: .leading) {
                Text("Meow!")
                .fontWeight(.black)
                Text("Mix")
            }
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            
        }
    }
}
#Preview {
    MeowMixHeader()
}
