//
//  PieceDetails.swift
//  Vinstage
//
//  Created by Roee Kleiner on 08/06/2023.
//

import SwiftUI

struct PieceDetails: View {
    let piece: Piece
    let imagesUrl = URL(string: "http://192.168.137.1:5000/api/images")!

    static let intervalFormatter: DateComponentsFormatter = {
        let componenetFormatter = DateComponentsFormatter()
        componenetFormatter.unitsStyle = .abbreviated
        componenetFormatter.allowedUnits = [.minute, .hour, .day]
        return componenetFormatter
    }()

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(piece.title)
                    .font(.title2)
                Text(
                    "Uploaded \(Self.intervalFormatter.string(from: Date.now.timeIntervalSince(piece.uploadTime))!) ago by \(piece.userId)"
                )
                .font(.subheadline)
                Divider()
                Text(piece.description)
                    .font(.body)
                Spacer()
            }
            AsyncImage(url: imagesUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ZStack {
                    Rectangle()
                    ProgressView()
                }
            }
            .cornerRadius(10)
        }

        .padding()
        .background(.thinMaterial)
        .cornerRadius(10)

    }
}

struct PieceDetails_Previews: PreviewProvider {
    static var previews: some View {
        PieceDetails(piece: Piece.samplePieces[0])
            .frame(height: 200)
    }
}
