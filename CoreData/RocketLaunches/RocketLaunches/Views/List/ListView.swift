import SwiftUI

struct ListView: View {
    @FetchRequest(sortDescriptors: [])
    var launchLists: FetchedResults<RocketLaunchList>
    var body: some View {
        Form {
            ForEach(launchLists, id: \.self) { launchList in
                NavigationLink(value: launchList) {
                    CirclularImageView(color: .red)
                    Text(launchList.name ?? "")
                }
            }
        }
        .navigationDestination(for: RocketLaunchList.self) { launchList in
            LaunchesView(launchList: launchList)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
