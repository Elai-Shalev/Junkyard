//
//  EditPieceView.swift
//  Vinstage
//
//  Created by Roee Kleiner on 08/06/2023.
//

import PhotosUI
import SwiftUI

struct EditPieceView: View {
    @Binding var piece: Piece

    @State var imageState: ImageState = ImageState.empty
    @State var imageSelection: PhotosPickerItem?
    @State var pieceImage: Image
    var body: some View {

        VStack {

            ZStack(alignment: .bottomLeading) {
                pieceImage
                    .resizable()
//                    .scaledToFill()
                    .cornerRadius(10)
                HStack {
                    TextField("NEW PIECE", text: $piece.title)
                        .font(.title)
                        .bold()
                        .padding()
                        .shadow(radius: 3)
                    Spacer()
                }
                .padding([.trailing])
            }

            Form {
                Section(
                    header: Text("Details"),
                    footer: Text("Listing will show as the current location")
                ) {
                    TextField("Description", text: $piece.description)
                    Picker("Category", selection: $piece.category) {
                        ForEach(
                            PieceCategory.allCases, id: \.rawValue
                        ) {
                            Label($0.rawValue, systemImage: $0.icon).tag($0)
                        }
                    }
                    HStack {
                        Text("Condition")
                        Spacer()
                        StarReview(rating: $piece.rating)
                    }
                }
                Section(header: Text("Images")) {
                    PhotosPicker("Select Image", selection: $imageSelection)
                }

            }
            .scrollContentBackground(.hidden)
            .onChange(of: imageSelection) { _ in
                Task {
                    if let data = try? await imageSelection?.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            pieceImage = Image(uiImage: uiImage)
                            return
                        }
                    }

                    print("Failed")
                }
            }

        }

    }

}

struct EditPieceView_Previews: PreviewProvider {
    static var previews: some View {
        EditPieceView(piece: .constant(Piece.samplePieces[0]), pieceImage: Image("Splash"))
    }
}
