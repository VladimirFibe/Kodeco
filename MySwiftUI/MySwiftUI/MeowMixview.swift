import SwiftUI

struct MeowMixview: View {
    let mix = MeowMix()
    var artists: [String] {
        mix.tracks.map(\.artist)
    }
    var body: some View {
        VStack(spacing: 0.0) {
            MeowMixHeader()
            Divider()
            List(mix.tracks) { track in
                TrackRow(track: track)
            }
            FeatureCats(artists: artists)
                .padding(.vertical)
                .background(Color.gray.opacity(0.2))
            Spacer()
        }
        .padding()
    }
}

struct TrackRow: View {
    let track: Track
    var body: some View {
        HStack {
            track.thumbnail
                .padding()
                .background(track.gradient)
                .cornerRadius(6)
            VStack(alignment: .leading) {
                Text(track.title)
                Text(track.artist)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            Spacer()
            
            
        }
        
    }
}

struct FeatureCats: View {
    let artists: [String]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Featured Cats")
                .font(.title)
                .padding()
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 25) {
                    ForEach(artists, id: \.self) { artist in
                        FeatureArtist(artist: artist)
                    }
                }
            }
        }
        
    }
}
struct FeatureArtist: View {
    let artist: String
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill([Color.orange, .pink, .purple, .red, .yellow].randomElement() ?? Color.green)
                    .scaledToFit()
                Image(systemName: "music.mic")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(.white)
            }
            Text(artist)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(width: 120)
    }
}

#Preview {
    MeowMixview()
}
