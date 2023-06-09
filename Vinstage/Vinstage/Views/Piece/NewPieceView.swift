//
//  NewPieceView.swift
//  Vinstage
//
//  Created by Roee Kleiner on 08/06/2023.
//

import SwiftUI

struct NewPieceView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.user) var user

    var pieceService: PieceService

    @Binding var viewActive: Bool
    let location: Location

    @State private var newPiece = Piece.emptyPiece
    @State var image: Image?

    var body: some View {

        if image == nil {
            withAnimation {
                PhotoCaptureView(showImagePicker: $viewActive, image: self.$image)
            }
        } else {
            withAnimation {
                NavigationStack {
                    EditPieceView(piece: $newPiece, pieceImage: image!)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    withAnimation(.spring()) {
                                        dismiss()
                                    }
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    Task {
                                        await uploadNewPiece()
                                    }
                                    // TODO: Add piece upload
                                    withAnimation(.spring()) {
                                        dismiss()
                                    }
                                }
                            }
                        }
                        .onAppear {
                            newPiece.userId = "236"
                            newPiece.location = location
                        }
                        .padding()
                        .cornerRadius(10)
                }
            }
        }

    }

    func uploadNewPiece() async {
        await pieceService.uploadNewPiece(newPiece)
    }
}

struct NewSensorView_Previews: PreviewProvider {
    static var previews: some View {
        NewPieceView(
            pieceService: PieceService(), viewActive: .constant(true),
            location: Location.init(latitude: 0, longitude: 0))
    }
}
