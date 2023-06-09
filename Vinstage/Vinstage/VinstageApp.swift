//
//  VinstageApp.swift
//  Vinstage
//
//  Created by Roee Kleiner on 08/06/2023.
//

import SwiftUI

@main
struct VinstageApp: App {
    
    var user = User.emptyUser
    var locationManager: LocationManager = LocationManager()
    let pieceService: PieceService = PieceService()
    
    var body: some Scene {
        WindowGroup {
            MainView(locationManager: locationManager,pieceService: pieceService)
                .environment(\.user, user)
        }

    }
}
