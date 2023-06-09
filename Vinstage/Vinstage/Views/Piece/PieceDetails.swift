//
//  PieceDetails.swift
//  Vinstage
//
//  Created by Roee Kleiner on 08/06/2023.
//

import SwiftUI


struct PieceDetails: View {
    let piece: Piece
    
    static let intervalFormatter: DateComponentsFormatter = {
        let componenetFormatter = DateComponentsFormatter()
        componenetFormatter.unitsStyle = .abbreviated
        return componenetFormatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
            Text(piece.title)
                .font(.title)
            Text("Uplaoded \(Self.intervalFormatter.string(from: Date.now.timeIntervalSince(piece.timeUploaded))!) ago")
                .font(.subheadline)
        }
        .border(.black)
    }
}

struct PieceDetails_Previews: PreviewProvider {
    static var previews: some View {
        PieceDetails(piece: Piece.samplePieces[0])
    }
}
