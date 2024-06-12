//
//  MapDemoView.swift
//  iOS17_New_API_Demo
//
//  Created by Lurich on 2023/6/11.
//

import SwiftUI
import MapKit

struct MapDemoView: View {
    @State private var cameraPosition: MapCameraPosition = .region(.myRegion)
    @State private var mapSelection: MKMapItem?
    @Namespace private var locationNamespace
    @State private var viewingRegion: MKCoordinateRegion?
    @State private var searchText: String = ""
    @State private var showSearch: Bool = false
    @State private var searchResults: [MKMapItem] = []
    @State private var showDetails: Bool = false
    @State private var lookAroundScene: MKLookAroundScene?
    @State private var routeDisplaying: Bool = false
    @State private var route: MKRoute?
    @State private var routeSelection: MKMapItem?
    
    var body: some View {
        ZStack {
            Map(position: $cameraPosition, selection: $mapSelection, scope: locationNamespace) {
                Annotation("Apple Park", coordinate: .myLocation) {
                    ZStack {
                        Image(systemName: "applelogo")
                            .font(.title3)
                        
                        Image(systemName: "square")
                            .font(.largeTitle)
                    }
                }
                .annotationTitles(.hidden)
                
                ForEach(searchResults, id: \.self) { mapItem in
                    if routeDisplaying {
                        if mapItem == routeSelection {
                            let placeMark = mapItem.placemark
                            Marker(placeMark.name ?? "placeMark", coordinate: placeMark.coordinate)
                        }
                    } else {
                        let placeMark = mapItem.placemark
                        Marker(placeMark.name ?? "placeMark", coordinate: placeMark.coordinate)
                    }
                }
                
                if let route {
                    MapPolyline(route.polyline)
                        .stroke(.blue, lineWidth: 7)
                }
                
                UserAnnotation()
            }
            .onMapCameraChange { ctx in
                viewingRegion = ctx.region
            }
            .mapControls {
                /// 地图比例视图
                MapScaleView()
            }
            .overlay(alignment: .bottomTrailing) {
                VStack(spacing: 15, content: {
                    /// 地图指南针
                    MapCompass(scope: locationNamespace)
                    /// 映射Pitch
                    MapPitchToggle(scope: locationNamespace)
                    /// 映射用户位置按钮
                    MapUserLocationButton(scope: locationNamespace)
                })
                .buttonBorderShape(.circle)
                .padding()
            }
            .mapScope(locationNamespace)
            .navigationTitle("Map")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, isPresented: $showSearch)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .toolbar(routeDisplaying ? .hidden : .visible, for: .navigationBar)
            .sheet(isPresented: $showDetails) {
                withAnimation(.snappy) {
                    if let boundingRect = route?.polyline.boundingMapRect, routeDisplaying {
                        cameraPosition = .rect(boundingRect)
                    }
                }
            } content: {
                MapDetails()
                    .presentationDetents([.height(300)])
                    .presentationBackgroundInteraction(.enabled(upThrough: .height(300)))
                    .presentationCornerRadius(15)
                    .invalidatableContent(true)
            }
            .safeAreaInset(edge: .bottom) {
                if routeDisplaying {
                    Button("End Route") {
                        withAnimation(.snappy) {
                            routeDisplaying = false
                            showDetails = true
                            mapSelection = routeSelection
                            cameraPosition = .region(.myRegion)
                            route = nil
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(.red.gradient, in: .rect(cornerRadius: 15))
                    .padding()
                    .background(.ultraThinMaterial)
                }
            }
        }
        .onSubmit(of: .search) {
            Task {
                guard !searchText.isEmpty else { return }
                await searchPlaces()
            }
        }
        .onChange(of: showSearch, initial: false) { oldValue, newValue in
            if !showSearch {
                searchResults.removeAll(keepingCapacity: false)
                showDetails = false
                if !routeDisplaying {
                    routeSelection = nil
                }
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
        VStack(spacing: 15, content: {
            ZStack(content: {
                if lookAroundScene == nil {
                    ContentUnavailableView("No Preview Available", systemImage: "eye.slash")
                } else {
                    LookAroundPreview(scene: $lookAroundScene)
                }
            })
            .frame(height: 200)
            .clipShape(.rect(cornerRadius: 15))
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    showDetails = false
                    withAnimation(.snappy) {
                        mapSelection = nil
                    }
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.black)
                        .background(.white.gradient, in: Circle())
                })
            }
            
            Button("Get Directions") {
                fetchRoute()
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(.blue.gradient, in: .rect(cornerRadius: 15))
        })
        .padding()
    }
    // star bucks
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
                routeSelection = mapSelection
            }
        }
    }
    
    func fetchRoute() {
        let request = MKDirections.Request()
        request.source = .init(placemark: .init(coordinate: .myLocation))
        request.destination = mapSelection
        
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

#Preview {
    NavigationStack {
        MapDemoView()
    }
}

extension CLLocationCoordinate2D {
    static var myLocation: CLLocationCoordinate2D {
//        return .init(latitude: 37.3346, longitude: -122.0090)
        return .init(latitude: 39.909187, longitude: 116.397455)
    }
}

extension MKCoordinateRegion {
    static var myRegion: MKCoordinateRegion {
        return .init(center: .myLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}
