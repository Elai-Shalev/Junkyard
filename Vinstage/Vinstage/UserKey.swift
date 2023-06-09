//
//  UserKey.swift
//  Vinstage
//
//  Created by Roee Kleiner on 08/06/2023.
//

import Foundation
import SwiftUI

private struct UserKey: EnvironmentKey {
    static var defaultValue: User = User.emptyUser

    typealias Value = User

}

extension EnvironmentValues {
    var user: User {
        get { self[UserKey.self] }
        set { self[UserKey.self] = newValue }
    }
}
