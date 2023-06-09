//
//  PieceAnnotation.swift
//  Vinstage
//
//  Created by Roee Kleiner on 08/06/2023.
//

import SwiftUI

struct PieceAnnotation: View {
    let piece: Piece
    var body: some View {
        ZStack {
            Circle()
                .fill(.gray)
                .frame(width: 35, height: 35)
            Text("📻")
            
        }
    }
}

struct PieceAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        PieceAnnotation(piece: Piece.samplePieces[0])
    }
}
