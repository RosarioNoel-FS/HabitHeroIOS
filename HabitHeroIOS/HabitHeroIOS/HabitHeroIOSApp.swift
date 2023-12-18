//
//  HabitHeroIOSApp.swift
//  HabitHeroIOS
//
//  Created by Noel Rosario on 12/9/23.
//

import SwiftUI
import FirebaseCore

// AppDelegate class for handling traditional UIApplicationDelegate events
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure() // Initialize Firebase
        return true
    }
}

class UserAuth: ObservableObject {
    @Published var isUserAuthenticated: Bool = false
}


@main
struct HabitHeroIOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var userAuth = UserAuth()

    var body: some Scene {
        WindowGroup {
            if userAuth.isUserAuthenticated {
                MainActivityView(userAuth: userAuth)
            } else {
                SignInView(userAuth: userAuth)
            }
        }
    }
}
