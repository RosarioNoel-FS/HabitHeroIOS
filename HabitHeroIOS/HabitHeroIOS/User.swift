//
//  User.swift
//  HabitHeroIOS
//
//  Created by Noel Rosario on 12/17/23.
//

import Foundation

struct User: Codable {
    var username: String

    // In Swift, a default initializer is automatically provided if all properties have default values.
    // So, if you need an empty constructor for Firestore deserialization, make sure all properties have default values or are optional.

    init(username: String = "") {
        self.username = username
    }
}
