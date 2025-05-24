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
        VStack {
            HStack {
                TextField("Enter Location", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .focused($isSearchFocused)

                Button {
                    Task {
                        await searchLocation()
                    }
                    isSearchFocused = false // Dismiss keyboard after search
                } label: {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(.title2)
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

            Spacer()
        }
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
            // Handle error appropriately (e.g., show an alert)
        }
    }
}

#Preview {
    MapView()
}
