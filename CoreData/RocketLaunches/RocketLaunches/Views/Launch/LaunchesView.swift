import SwiftUI

struct LaunchesView: View {
    @State private var isShowingCreateModal = false
    let launchesFetchRequest: FetchRequest<RocketLaunch>
    var launches: FetchedResults<RocketLaunch> {
        launchesFetchRequest.wrappedValue
    }
    
    let sortTypes = [
        (name: "Name",
         descriptors: [SortDescriptor(\RocketLaunch.name, order: .forward)]),
        (name: "LaunchDate",
         descriptors: [SortDescriptor(\RocketLaunch.launchDate, order: .forward)])
    ]
    let launchList: RocketLaunchList
    
    init(launchList: RocketLaunchList) {
        self.launchList = launchList
        self.launchesFetchRequest = RocketLaunch.launches(in: launchList)
    }
    @State private var activeSortIndex = 0
    var body: some View {
        VStack {
            List {
                Section {
                    ForEach(launches, id: \.self) { launch in
                        NavigationLink(value: launch) {
                            HStack {
                                LaunchStatusView(isViewed: launch.isViewed)
                                Text(launch.name)
                            }
                        }
                    }
                }
            }
            .background(Color.white)
            NewLaunchButton(isShowingCreateModal: $isShowingCreateModal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
        }
        .navigationTitle("Launches")
        .sheet(isPresented: $isShowingCreateModal) {
            LaunchCreateView(list: launchList)
        }
        .navigationDestination(for: RocketLaunch.self) { launch in
            LaunchDetailView(launch: launch)
        }
        .onChange(of: activeSortIndex) { _ in
            launches.sortDescriptors = sortTypes[activeSortIndex].descriptors
        }
        .toolbar {
            Menu {
                Picker(selection: $activeSortIndex) {
                    ForEach(0..<sortTypes.count, id: \.self) { index in
                        let sortType = sortTypes[index]
                        Text(sortType.name)
                    }
                } label: {
                    
                }

            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle.fill")
            }

        }
    }
}

//struct LaunchesView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchesView()
//    }
//}
