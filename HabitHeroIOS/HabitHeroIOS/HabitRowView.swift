//
//  HabitRowView.swift
//  HabitHeroIOS
//
//  Created by Noel Rosario on 12/17/23.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase


struct HabitRowView: View {
    @Binding var habit: Habit
    @Binding var habits: [Habit]
    @State private var showAlert = false
    private var firebaseHelper: FirebaseHelper
    private let userId: String

    init(habit: Binding<Habit>, habits: Binding<[Habit]>, firebaseHelper: FirebaseHelper) {
        self._habit = habit
        self._habits = habits
        self.firebaseHelper = firebaseHelper
        self.userId = Auth.auth().currentUser?.uid ?? ""
    }
    
    var body: some View {
        HStack {
            // Display the habit name
            Text(habit.name)
                .foregroundColor(Color.black) // Text color
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .frame(minWidth: 0, maxWidth: .infinity) // To ensure it takes up the available space

            // Habit Check Box Image with Tap Gesture
            Image(habit.completed ? "checked_box" : "unchecked_box")
                .resizable()
                .frame(width: 25, height: 25)
                .onTapGesture {
                    self.showAlert = true
                }
        }
        .padding(16)
        .background(Color.yellow) // Background color
        .cornerRadius(10)
        .shadow(radius: 15)
        .padding(15)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Manage Habit"),
                  message: Text("Choose your action for this habit:"),
                  primaryButton: .destructive(Text("Delete")) {
                    // Call FirebaseHelper to delete the habit
                    firebaseHelper.deleteHabit(userId: Auth.auth().currentUser?.uid ?? "", habitId: habit.id ?? "") { result in
                        // Handle deletion result
                        switch result {
                        case .success():
                            // Remove habit from the list
                            if let index = habits.firstIndex(where: { $0.id == habit.id }) {
                                habits.remove(at: index)
                            }
                        case .failure(let error):
                            print("Error deleting habit: \(error.localizedDescription)")
                        }
                    }
                  },
                  secondaryButton: .default(Text("Complete")) {
                    // Call FirebaseHelper to update the habit's completion status
                    var updatedHabit = habit
                    updatedHabit.completed = true
                    firebaseHelper.updateCompletedHabit(userId: Auth.auth().currentUser?.uid ?? "", habit: updatedHabit) { result in
                        // Handle the result of the update
                        switch result {
                        case .success():
                            habit.completed = true // Update habit's completed status in the list
                        case .failure(let error):
                            print("Error updating habit: \(error.localizedDescription)")
                        }
                    }
                  })
        }
    }
}

struct HabitRowView_Previews: PreviewProvider {
    // Sample habit for preview
    @State static var sampleHabit = Habit(name: "Sample Habit",
                                          category: "Sample Category",
                                          completionHour: 20,
                                          completionMinute: 0,
                                          iconUrl: "icon_placeholder",
                                          completed: false)
    // Sample habits array for preview
    @State static var sampleHabits = [sampleHabit]

    static var previews: some View {
        HabitRowView(habit: $sampleHabit, habits: $sampleHabits, firebaseHelper: FirebaseHelper())
    }
}
