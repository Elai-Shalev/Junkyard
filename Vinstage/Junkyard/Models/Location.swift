//
//  Location.swift
//  Vinstage
//
//  Created by Roee Kleiner on 08/06/2023.
//

import Foundation
import MapKit

struct Location: Codable {
    let latitude: Double
    let longitude: Double

    var clCoordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    init(clLocation: CLLocation) {
        self.init(
            latitude: clLocation.coordinate.latitude, longitude: clLocation.coordinate.longitude)
    }
}
