import SwiftUI

import SwiftUI
import Firebase

struct HomeView: View {
    @State private var habits: [Habit] = []
    @State private var isLoading: Bool = true
    
    // Example FirebaseHelper instance (ensure you have an appropriate initializer)
    private var firebaseHelper = FirebaseHelper()
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(gradient: Gradient(colors: [Color(hex: "#15313F"), Color(hex: "#04080B")]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Custom navigation bar items
                customNavigationBar
                
                // Main content
                if isLoading {
                    ProgressView()
                } else {
                    mainContentView
                }
                
                // Floating Action Button
                floatingActionButton
            }
        }
        .onAppear {
            fetchHabits()
        }
    }
    
    private var customNavigationBar: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading) {
                Image("home_info_button") // App Icon
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.leading, 20)
                    .padding(.trailing, 40)
            }
        }
        .padding(.top, 20)
    }
    
    private var mainContentView: some View {
        Group {
            if habits.isEmpty {
                // View for empty habit list
                Text("No habits yet. Start by adding a new habit.")
                    .padding()
                    .multilineTextAlignment(.center)
            } else {
                List($habits, id: \.id) { $habit in
                    HabitRowView(habit: $habit, habits: $habits, firebaseHelper: firebaseHelper)
                }
            }
        }
    }

    
    private var floatingActionButton: some View {
        Button(action: {
            // Action for button
        }) {
            Image("plus_icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .padding()
        }
        .background(Color.yellow)
        .foregroundColor(.white)
        .clipShape(Circle())
        .padding()
        .shadow(radius: 10)
        .overlay(Circle().stroke(Color.white, lineWidth: 2))
    }
    
    private func fetchHabits() {
        isLoading = true
        firebaseHelper.fetchUserHabits(userId: Auth.auth().currentUser?.uid ?? "") { result in
            isLoading = false
            switch result {
            case .success(let fetchedHabits):
                self.habits = fetchedHabits
                print("Fetched Habits: \(fetchedHabits)")  // Add this line
            case .failure(let error):
                print("Error fetching habits: \(error.localizedDescription)")
            }
        }
    }
}




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}



