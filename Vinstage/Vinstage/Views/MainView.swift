//
//  ContentView.swift
//  Vinstage
//
//  Created by Roee Kleiner on 08/06/2023.
//

import SwiftUI

struct MainView: View {

    let locationManager: LocationManager
    let pieceService: PieceService
    @State var pieces: [Piece] = []
    @State var index: Int = 0
    @State var selectedPiece: Piece? = nil
    @State var toggleNewPiece = false
    var body: some View {
        
        ZStack(alignment: .bottom) {
            MapView(
                locationManager: locationManager, pieces: $pieces
            ).onReceive(locationManager.$lastLocation) {
                newLocation in
                if pieces.isEmpty {
                    if let clloc = newLocation {
                        Task {
                            await getPieces(location: Location(clLocation: clloc))
                        }
                    }
                }
            }
            .zIndex(-1)
            VStack {
                if let piece = selectedPiece {
                    PieceDetails(piece: piece)
                        .padding()
                        .transition(.move(edge: .top))
                        .zIndex(1)
                        .frame(height: 200)
                }
                Spacer()
                Button {
                    withAnimation(.spring()) { toggleNewPiece = true }
                } label: {
                    Text("Upload New Piece")
                }
                .buttonStyle(.borderedProminent)
                .frame(alignment: .bottom)
                .shadow(radius: 5)
                .padding()
            }
            .zIndex(1)
        }.onAppear {
            locationManager.locationManager.requestLocation()
        }
    }

    func getPieces(location: Location) async {
        let pieces = await pieceService.getNearbyPieces(
            location: location,
            radius: 1000
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
