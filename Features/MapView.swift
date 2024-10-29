//
//  MapView.swift
//  Features
//
//  Created by Stuart Minchington on 10/28/24.
//
import CoreLocation
import MapKit
import SwiftUI

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()

    var body: some View {
        Map(position: $viewModel.cameraPosition) {
            UserAnnotation()
        }
        .onAppear {
            viewModel.requestLocationPermission()
        }
    }
}

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.334_900, longitude: -122.009_020), // Default location
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        cameraPosition = .region(MKCoordinateRegion(center: location.coordinate, span: cameraPosition.region?.span ?? MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    }
}
