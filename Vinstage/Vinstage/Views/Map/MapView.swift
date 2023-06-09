//
//  MapView.swift
//  Vinstage
//
//  Created by Roee Kleiner on 08/06/2023.
//

import MapKit
import SwiftUI

var region = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 32.0853, longitude: 34.7818),
    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))

struct MapView: View {
    let locationManager: LocationManager
    @Binding var pieces: [Piece]
    var body: some View {
        Map(coordinateRegion: .constant(region),showsUserLocation: true)
            .ignoresSafeArea(.all)
            .onAppear {
                if locationManager.authorizationStatus != .authorizedWhenInUse {
                    locationManager.requestAuth()
                }
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(locationManager: LocationManager(), pieces: .constant([]))
    }
}
