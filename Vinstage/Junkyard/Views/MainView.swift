//
//  ContentView.swift
//  Vinstage
//
//  Created by Roee Kleiner on 08/06/2023.
//

import CoreLocation
import SwiftUI

struct MainView: View {

    let locationManager: LocationManager
    let pieceService: PieceService

    @State var pieces: [Piece] = []
    @State var toggleNewPiece = false
    @State var isActive = false

    var body: some View {

        ZStack {
            if isActive {
                MapView(
                    locationManager: locationManager, pieces: $pieces, toggleNewPiece: $toggleNewPiece
                ).onReceive(locationManager.$lastLocation) {
                    newLocation in
                    if pieces.isEmpty {
                        if newLocation != nil {
                            Task { await getPieces() }
                        }
                    }

                }
            } else {
                Rectangle()
                    .fill(.white)
                    .ignoresSafeArea(.all)
                Image("Splash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .sheet(
            isPresented: $toggleNewPiece,
            onDismiss: { Task { await getPieces() } }
        ) {
            NewPieceView(
                pieceService: pieceService, viewActive: .constant(true),
                location: locationManager.lastLocation
                    ?? Location(
                        latitude: TLV_REGION.center.latitude,
                        longitude: TLV_REGION.center.longitude))
        }
        .onAppear {
            locationManager.locationManager.requestLocation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    self.isActive = true
                }
            }
        }

    }

    func getPieces() async {
        guard let loc = locationManager.lastLocation else {
            return
        }
        let pieces = await pieceService.getNearbyPieces(
            location: loc,
            radius: 3750
        )
        self.pieces = pieces
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(
            locationManager: LocationManager(), pieceService: PieceService(),
            pieces: Piece.samplePieces)
    }
}
