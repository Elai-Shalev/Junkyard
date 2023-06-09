//
//  PieceImage.swift
//  Vinstage
//
//  Created by Roee Kleiner on 08/06/2023.
//

import SwiftUI

enum ImageState {
    case empty
    case loading(Progress)
    case success(Image)
    case failure(Error)
}

enum TransferError: Error {
    case importFailed
}

struct PieceImageView: View {
    let imageState: ImageState

    var body: some View {
        switch imageState {
        case .success(let image):
            image.resizable()
        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "person.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}

struct PieceImage_Previews: PreviewProvider {
    static var previews: some View {
        PieceImageView(imageState: .success(Image(systemName: "sofa")))
    }
}
