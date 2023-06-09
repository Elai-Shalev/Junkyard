//
//  MapView.swift
//  Vinstage
//
//  Created by Roee Kleiner on 08/06/2023.
//

import CoreLocationUI
import MapKit
import SwiftUI

var TLV_REGION = MKCoordinateRegion(
    center: CLLocationCoordinate2D(latitude: 32.0853, longitude: 34.7818),
    latitudinalMeters: 1000, longitudinalMeters: 1000)

struct MapView: View {
    let locationManager: LocationManager
    @Binding var pieces: [Piece]
    @Binding var toggleNewPiece: Bool
    //    @State var selectedPiece: Piece?
    @State var togglePieces: Bool = false
    @State var index = -1

    @StateObject private var regionWrapper = RegionWrapper()
    @State var userTrackingMode = MapUserTrackingMode.none

    var body: some View {
        ZStack {
            Map(
                coordinateRegion: regionWrapper.region, showsUserLocation: true,
                userTrackingMode: $userTrackingMode, annotationItems: $pieces
            ) { $piece in
                MapAnnotation(coordinate: piece.location.clCoordinate) {
                    PieceAnnotation(piece: piece)
                        .gesture(
                            DragGesture(minimumDistance: 0).onEnded { _ in
                                let newIndex = pieces.firstIndex(where: { $0._id == piece._id })!
                                if newIndex == index {
                                    togglePieces.toggle()
                                } else {
                                    index = newIndex
                                    updateRegion(
                                        newRegion: MKCoordinateRegion(
                                            center: piece.location.clCoordinate,
                                            latitudinalMeters: 1000, longitudinalMeters: 1000),
                                        togglePieces: true)
                                }
                            })
                }
            }
            .onReceive(locationManager.$lastLocation) {
                location in
                guard let loc = location else {
                    return
                }
                updateRegion(
                    newRegion: MKCoordinateRegion(
                        center: loc.clCoordinate,
                        latitudinalMeters: 1000, longitudinalMeters: 1000), togglePieces: false)
            }
            .ignoresSafeArea(.all)
            .zIndex(-1)

            VStack(alignment: .trailing) {
                if togglePieces {
                    TabView(selection: $index) {
                        ForEach((0..<pieces.count), id: \.self) { index in
                            PieceDetails(piece: pieces[index])
                                .padding()
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(height: 250)
                    .shadow(radius: 3)
                    .onChange(
                        of: index,
                        perform: { (index) in
                            updateRegion(
                                newRegion: MKCoordinateRegion(
                                    center: pieces[index].location.clCoordinate,
                                    latitudinalMeters: 1000, longitudinalMeters: 1000),
                                togglePieces: true)
                        })
                }
                Spacer()
                LocationButton(.currentLocation) {
                    print(userTrackingMode)
                    if userTrackingMode == .none {
                        userTrackingMode = .follow
                    } else {
                        userTrackingMode = .none
                    }
                }
                .symbolVariant(.fill)
                .labelStyle(.iconOnly)
                .cornerRadius(4)
                .padding()
                .foregroundColor(.white)
                HStack {
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
                    Spacer()
                }

            }.zIndex(1)
        }
        .onTapGesture {
            togglePieces = false
        }
        .onAppear {
            if locationManager.authorizationStatus != .authorizedWhenInUse {
                locationManager.requestAuth()
            }
        }
    }
    func updateRegion(newRegion: MKCoordinateRegion, togglePieces: Bool) {
        withAnimation {
            regionWrapper.region.wrappedValue = newRegion
            regionWrapper.flag.toggle()
            self.togglePieces = togglePieces
        }
    }
    func updateRegion(coords: CLLocationCoordinate2D) {
        withAnimation {
            let newRegion = MKCoordinateRegion(
                center: coords, latitudinalMeters: 1000, longitudinalMeters: 1000)
            regionWrapper.region.wrappedValue = newRegion
            regionWrapper.flag.toggle()
        }
    }

}

class RegionWrapper: ObservableObject {
    var _region: MKCoordinateRegion = TLV_REGION

    var region: Binding<MKCoordinateRegion> {
        Binding(
            get: { self._region },
            set: { self._region = $0 }
        )
    }

    @Published var flag = false
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {

        MapView(
            locationManager: LocationManager(), pieces: .constant(Piece.samplePieces),
            toggleNewPiece: .constant(false)
        )
    }
}
