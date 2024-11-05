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
    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
        }.mapControls {
            MapUserLocationButton()
        }
        .onAppear {
            manager.requestWhenInUseAuthorization()
        }
    }
}

#Preview {
    MapView()
}

