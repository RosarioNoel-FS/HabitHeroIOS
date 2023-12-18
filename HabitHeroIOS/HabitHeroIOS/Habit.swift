//
//  Habit.swift
//  HabitHeroIOS
//
//  Created by Noel Rosario on 12/17/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Habit: Codable, Identifiable {
    @DocumentID var id: String?
    var name: String
    var category: String
    var iconUrl: String
    var completionHour: Int
    var completionMinute: Int
    var completed: Bool
    var timestamp: Timestamp
    var streakCount: Int
    var completionCount: Int
    var completionDates: [String]?

    // Modified initializer to include `completed` parameter
        init(name: String, category: String, completionHour: Int, completionMinute: Int, iconUrl: String, completed: Bool = false) {
            self.name = name
            self.category = category
            self.iconUrl = iconUrl
            self.completionHour = completionHour
            self.completionMinute = completionMinute
            self.timestamp = Timestamp(date: Date())
            self.completed = completed
            self.streakCount = 0
            self.completionCount = 0
            self.completionDates = []
        }

    // Example of a computed property
//    var isCompletedToday: Bool {
//        get {
//            // Define logic to determine if the habit is completed today
//        }
//        set {
//            // Define logic to update the habit's completion status
//        }
//    }
}
