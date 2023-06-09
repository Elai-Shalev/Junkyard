//
//  User.swift
//  Vinstage
//
//  Created by Roee Kleiner on 08/06/2023.
//

import Foundation

struct User: Identifiable,Codable {
    let id: UUID
    let username: String
    let name: String

    static let userSamples = [
        User(id: UUID(), username: "roee", name: "Roee Kleiner"),
        User(id: UUID(), username: "nitzan", name: "Nitzan Yitshar"),
        User(id: UUID(), username: "elai", name: "Elai Shalev"),
        User(id: UUID(), username: "tal", name: "Tal Harel"),
    ]
    static let emptyUser = User(id: UUID(), username: "", name: "")
}
