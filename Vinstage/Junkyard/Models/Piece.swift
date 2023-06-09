//
//  Piece.swift
//  Vinstage
//
//  Created by Roee Kleiner on 08/06/2023.
//

import Foundation
import PhotosUI
import SwiftUI

enum PieceCategory: String, Codable, CaseIterable {
    case electronics = "Electronics"
    case sofaOrChair = "Sofa / Chair"
    case clothes = "Clothes"
    case books = "Books"
    case lamps = "Lamps"
    case other = "Other"

    var icon: String {
        switch self {
        case .electronics:
            return "ipod"
        case .sofaOrChair:
            return "sofa.fill"
        case .clothes:
            return "tshirt.fill"
        case .books:
            return "books.vertical.fill"
        case .lamps:
            return "lamp.floor.fill"
        case .other:
            return "questionmark"

        }
    }
}

struct Piece: Identifiable, Codable {
    var id: UUID? = UUID()
    var _id: String
    var title: String
    var userId: String
    var description: String
    var location: Location
    var imageUrl: String
    var uploadTime: Date
    var rating: Int = 3
    var category: PieceCategory = .other

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(UUID.self, forKey: .id)
        self._id = try container.decode(String.self, forKey: ._id)
        self.title = try container.decode(String.self, forKey: .title)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.description = try container.decode(String.self, forKey: .description)
        self.location = try container.decode(Location.self, forKey: .location)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.uploadTime = try container.decode(Date.self, forKey: .uploadTime)
        self.rating = Int.random(in: 0...5)
        self.category = PieceCategory.allCases.randomElement() ?? .other
    }

    init(
        id: UUID? = nil, _id: String, title: String, userId: String, description: String,
        location: Location, imageUrl: String, uploadTime: Date, rating: Int, category: PieceCategory
    ) {
        self.id = id
        self._id = _id
        self.title = title
        self.userId = userId
        self.description = description
        self.location = location
        self.imageUrl = imageUrl
        self.uploadTime = uploadTime
        self.rating = rating
        self.category = category
    }

    static var samplePieces = [
        Piece(
            _id: "", title: "Piece 1", userId: "1", description: "This is a piece",
            location: Location(latitude: 32.0863, longitude: 34.7818),
            imageUrl: "https://picsum.photos/200", uploadTime: Date(), rating: 3, category: .books),
        Piece(
            _id: "", title: "Piece 2", userId: "2", description: "This is a piece",
            location: Location(latitude: 32.0844, longitude: 34.7819),
            imageUrl: "https://picsum.photos/200", uploadTime: Date(), rating: 3, category: .clothes
        ),
    ]
    static var emptyPiece = Piece(
        _id: "", title: "", userId: "0", description: "",
        location: Location(latitude: 0, longitude: 0), imageUrl: "", uploadTime: Date(), rating: 3,
        category: .other)

}
