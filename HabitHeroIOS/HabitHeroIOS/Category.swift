//
//  Category.swift
//  HabitHeroIOS
//
//  Created by Noel Rosario on 12/17/23.
//

import Foundation

struct Category: Codable {
    var name: String
    var habitList: [String]
    var iconUrl: String

    // Computed property example
    var iconURLResolved: URL? {
        URL(string: iconUrl)
    }
}

