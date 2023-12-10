//
//  HabitHeroIOSApp.swift
//  HabitHeroIOS
//
//  Created by Noel Rosario on 12/9/23.
//

import SwiftUI

@main
struct HabitHeroIOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
