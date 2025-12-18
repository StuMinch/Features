//
//  MapView.swift
//  Features
//
//  Created by Stuart Minchington on 10/28/24.
//
import MapKit
import SwiftUI

struct MapView: View {
    let manager = CLLocationManager()
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var searchText: String = ""
    @State private var searchedLocation: CLLocationCoordinate2D?
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        ZStack {
            SauceColors.background.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    TextField("Enter Location", text: $searchText)
                        .textFieldStyle(.plain)
                        .padding()
                        .background(SauceColors.secondaryBackground)
                        .foregroundColor(SauceColors.textPrimary)
                        .cornerRadius(8)
                        .focused($isSearchFocused)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(SauceColors.accent.opacity(0.5), lineWidth: 1)
                        )

                    Button {
                        Task {
                            await searchLocation()
                        }
                        isSearchFocused = false
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.title2)
                            .foregroundColor(SauceColors.accent)
                    }
                    .padding(.leading, 8)
                }
                .padding()

                Map(position: $cameraPosition) {
                    UserAnnotation()

                    if let searchedLocation = searchedLocation {
                        Marker("Searched Location", coordinate: searchedLocation)
                    }
                }
                .mapControls {
                    MapUserLocationButton()
                }
                .onAppear {
                    manager.requestWhenInUseAuthorization()
                }
                .cornerRadius(12)
                .padding([.horizontal, .bottom])

                Spacer()
            }
        }
        .navigationTitle("Geolocation")
    }

    func searchLocation() async {
        guard !searchText.isEmpty else { return }

        let geocoder = CLGeocoder()
        do {
            let placemarks = try await geocoder.geocodeAddressString(searchText)
            if let firstPlacemark = placemarks.first?.location?.coordinate {
                searchedLocation = firstPlacemark
                // Adjust camera to show both user location and searched location
                if let userLocation = manager.location?.coordinate {
                    let region = MKCoordinateRegion(
                        center: CLLocationCoordinate2D(
                            latitude: (userLocation.latitude + firstPlacemark.latitude) / 2,
                            longitude: (userLocation.longitude + firstPlacemark.longitude) / 2
                        ),
                        span: MKCoordinateSpan(latitudeDelta: abs(userLocation.latitude - firstPlacemark.latitude) * 1.5,
                                           longitudeDelta: abs(userLocation.longitude - firstPlacemark.longitude) * 1.5)
                    )
                    cameraPosition = .region(region)
                } else {
                    cameraPosition = .region(MKCoordinateRegion(center: firstPlacemark, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)))
                }
            }
        } catch {
            print("Error geocoding: \(error)")
        }
    }
}

#Preview {
    MapView()
}
