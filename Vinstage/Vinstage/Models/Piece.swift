//
//  Piece.swift
//  Vinstage
//
//  Created by Roee Kleiner on 08/06/2023.
//

import Foundation

struct Piece: Identifiable {
    var id = UUID()
    let title: String
    let userId: UUID
    let description: String
    let location: Location
    let imageUrl: String
    let timeUploaded: Date
}
