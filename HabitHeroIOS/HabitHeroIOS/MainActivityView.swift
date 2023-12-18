//
//  MainActivityView.swift
//  HabitHeroIOS
//
//  Created by Noel Rosario on 12/11/23.
//

import SwiftUI
import UIKit

// UINavigationBarAppearance extension to change the navigation bar color
extension View {
    func navigationBarColor(backgroundColor: UIColor?, textColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, textColor: textColor))
    }
}

struct NavigationBarModifier: ViewModifier {
    var backgroundColor: UIColor?
    var textColor: UIColor?

    init(backgroundColor: UIColor?, textColor: UIColor?) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: textColor ?? .white]
        appearance.largeTitleTextAttributes = [.foregroundColor: textColor ?? .white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    func body(content: Content) -> some View {
        content
    }
}

struct MainActivityView: View {
    @State private var selectedTab: Tab = .home
    @State private var isUserLoggedIn = true  // State to track if the user is logged in
    @State private var showProfileView = false  // State to control navigation to ProfileView
    @ObservedObject var userAuth: UserAuth


    var body: some View {
        Group {
            

            if isUserLoggedIn {
                NavigationView {
                    TabView(selection: $selectedTab) {
                        HomeView()
                            .tabItem {
                                Label("Home", systemImage: "house.fill")
                            }
                            .tag(Tab.home)
                        
                        RewardsView()
                            .tabItem {
                                Label("Rewards", systemImage: "gift.fill")
                            }
                            .tag(Tab.rewards)
                        // Add more tabs as needed
                    }
                    .accentColor(Color(red: 0.997, green: 0.744, blue: 0.005))
                    .background(Color("background_color"))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Image("app_logo")
                                .resizable()
                                .frame(width: 50, height: 35)
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                self.showProfileView = true
                            }) {
                                Image("profile_image")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }

                    .background(
                        NavigationLink(
                            destination: ProfileView(userAuth: userAuth), // Pass UserAuth instance
                            isActive: $showProfileView
                        ) { EmptyView() }
                    )
                }.id(isUserLoggedIn)
            } else {
                SignInView(userAuth: userAuth)  // Show SignInView when not logged in
            }
        }.navigationBarColor(backgroundColor: UIColor.systemYellow, textColor: UIColor.black) // Apply the custom navigation bar color

    }
}

enum Tab {
    case home
    case rewards
    // Add other tabs as needed
}

struct MainActivityView_Previews: PreviewProvider {
    static var previews: some View {
        let userAuth = UserAuth() // Create a dummy UserAuth for preview purposes
        MainActivityView(userAuth: userAuth)
    }
}
