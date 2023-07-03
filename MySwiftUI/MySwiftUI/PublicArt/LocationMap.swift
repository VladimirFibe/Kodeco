import SwiftUI
import MapKit

struct LocationMap: View {
    @State private var cameraPosition: MapCameraPosition = .region(.myRegion)
    @Namespace private var locationSpace
    @State private var searchText = ""
    @State private var showSearch = false
    @State private var mapSelection: MKMapItem?
    @State private var searchResults: [MKMapItem] = []
    @State private var showDetails = false
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var viewingRegion: MKCoordinateRegion?
    @State private var routeDisplaying = false
    @State private var route: MKRoute?
    @State private var routeDestination: MKMapItem?
    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition, selection: $mapSelection, scope: locationSpace) {
                Annotation("Apple Park", coordinate: .myLocation) {
                    ZStack {
                        Image(systemName: "applelogo")
                            .padding(8)
                            .overlay {
                                Rectangle().stroke().aspectRatio(contentMode: .fit)
                            }
                    }
                }
                .annotationTitles(.hidden)
                ForEach(searchResults, id: \.self) { mapItem in
                    if routeDisplaying {
                        if mapItem == routeDestination {
                            let placemark = mapItem.placemark
                            Marker(placemark.name ?? "Place", coordinate: placemark.coordinate)
                                .tint(.blue)
                        }
                    } else {
                        let placemark = mapItem.placemark
                        Marker(placemark.name ?? "Place", coordinate: placemark.coordinate)
                            .tint(.blue)
                    }
                }
                
                if let route {
                    MapPolyline(route.polyline)
                        .stroke(.blue, lineWidth: 7)
                }
                UserAnnotation()
            }
            .onMapCameraChange {
                viewingRegion = $0.region
            }
            .overlay(alignment: .bottomTrailing) {
                VStack {
                    MapCompass(scope: locationSpace)
                    MapPitchButton(scope: locationSpace)
                    MapUserLocationButton(scope: locationSpace)
                }
                .buttonBorderShape(.circle)
                .padding()
            }
            .mapScope(locationSpace)
            .navigationTitle("Map")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, isPresented: $showSearch)
            .toolbar(routeDisplaying ? .hidden : .visible, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .sheet(isPresented: $showDetails, onDismiss: {
                if let boundingRect = route?.polyline.boundingMapRect,
                routeDisplaying {
                    cameraPosition = .rect(boundingRect)
                }
            }, content: {
                MapDetails()
                    .presentationDetents([.height(300)])
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(300)))
                    .presentationCornerRadius(25)
                    .interactiveDismissDisabled()
            })
            .safeAreaInset(edge: .bottom) {
                if routeDisplaying {
                    Button("End Route") {
                        withAnimation(.snappy) {
                            routeDisplaying = false
                            showDetails = true
                            mapSelection = routeDestination
                            routeDestination = nil
                            route = nil
                            cameraPosition = .region(.myRegion)
                        }
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(.red.gradient, in: .rect(cornerRadius: 15))
                    .padding()
                    .background(.ultraThinMaterial)
                }
            }
        }
        .onSubmit(of: .search) {
            guard !searchText.isEmpty else { return }
            Task { await searchPlaces()}
        }
        .onChange(of: showSearch, initial: false) {
            if !showSearch {
                searchResults.removeAll(keepingCapacity: false)
                showDetails = false
                withAnimation(.snappy) {
                    cameraPosition = .region(.myRegion)
                }
            }
        }
        .onChange(of: mapSelection) { oldValue, newValue in
            showDetails = newValue != nil
            fetchLookAroundPreview()
        }
    }
    
    @ViewBuilder
    func MapDetails() -> some View {
        VStack(spacing: 15.0) {
            ZStack {
                if lookAroundScene == nil {
                    ContentUnavailableView("No Preview Available", systemImage: "eye.slash")
                } else {
                    LookAroundPreview(scene: $lookAroundScene)
                }
            }
            .frame(height: 200)
            .clipShape(.rect(cornerRadius: 15))
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    showDetails.toggle()
                    withAnimation(.snappy) {
                        mapSelection = nil
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(.black)
                        .background(.white, in: .circle)
                        .padding(10)
                }
            }
            Button("Get Directions", action: fetchRoute)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(.blue.gradient, in: .rect(cornerRadius: 15))
        }
        .padding(15)
    }
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = viewingRegion ?? .myRegion
        let results = try? await MKLocalSearch(request: request).start()
        searchResults = results?.mapItems ?? []
    }
    func fetchLookAroundPreview() {
        if let mapSelection {
            lookAroundScene = nil
            Task {
                let request = MKLookAroundSceneRequest(mapItem: mapSelection)
                lookAroundScene = try? await request.scene
            }
        }
    }
    func fetchRoute() {
        if let mapSelection {
            let request = MKDirections.Request()
            request.source = .init(placemark: .init(coordinate: .myLocation))
            request.destination = mapSelection
            routeDestination = mapSelection
            Task {
                let result = try? await MKDirections(request: request).calculate()
                route = result?.routes.first
                withAnimation(.snappy) {
                    routeDisplaying = true
                    showDetails = false
                }
            }
        }
    }
}

extension CLLocationCoordinate2D {
    static var myLocation: CLLocationCoordinate2D {
        .init(latitude: 37.3346, longitude: -122.0090)
    }
}

extension MKCoordinateRegion {
    static var myRegion: MKCoordinateRegion {
        .init(center: .myLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}

#Preview {
    LocationMap()
}

