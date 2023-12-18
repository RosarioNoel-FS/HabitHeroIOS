//
//  asasasApp.swift
//  asasas
//
//  Created by Noel Rosario on 12/16/23.
//

import SwiftUI

@main
struct asasasApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
