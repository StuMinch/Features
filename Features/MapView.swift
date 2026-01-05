//
//  MapView.swift
//  Features
//
//  Created by Stuart Minchington on 10/28/24.
//
import MapKit
import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        self.authorizationStatus = manager.authorizationStatus
    }

    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            self.authorizationStatus = manager.authorizationStatus
            if self.authorizationStatus == .authorizedWhenInUse || self.authorizationStatus == .authorizedAlways {
                manager.startUpdatingLocation()
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            DispatchQueue.main.async {
                self.userLocation = location.coordinate
            }
        }
    }
}

struct MapView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)

    var body: some View {
        ZStack {
            SauceColors.background.edgesIgnoringSafeArea(.all)
            
            VStack {
                // Permission Warning / Button
                if locationManager.authorizationStatus == .notDetermined {
                    Button("Enable Location Access") {
                        locationManager.requestPermission()
                    }
                    .buttonStyle(SauceButtonStyle())
                    .padding(.top)
                } else if locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .restricted {
                    Text("Location Access Denied. Please enable in Settings.")
                        .font(SauceTypography.captionFont)
                        .foregroundColor(.red)
                        .padding(.top)
                }

                Map(position: $cameraPosition) {
                    UserAnnotation()
                }
                .mapControls {
                    MapUserLocationButton()
                    MapCompass()
                    MapScaleView()
                }
                .onAppear {
                    locationManager.requestPermission()
                }
                .cornerRadius(12)
                .padding()

                Spacer()
            }
        }
        .navigationTitle("Geolocation")
    }
}

#Preview {
    MapView()
}
