//
//  UsernameView.swift
//  HabitHeroIOS
//
//  Created by Noel Rosario on 12/9/23.
//

import SwiftUI

struct UsernameView: View {
    @State private var username: String = ""

    var body: some View {
        ZStack {
            // Background image
            Image("username_image") // Replace with your image name
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.horizontal)

            VStack(spacing: 33) {
                Spacer() // This spacer will push the content down

                // Username TextField
                TextField("username", text: $username)
                    .frame(width: 300, height: 40)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black) // Replace with your color

                // Confirm Button
                Button(action: {
                    // Add action for confirm button
                }) {
                    Text("Confirm")
                        .frame(width: 220, height: 40)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue)) // Replace with your button color
                        .foregroundColor(Color.white) // Replace with your text color
                }

                Spacer() // This spacer will balance the space at the bottom
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, 100) // Increase this value to move the content further down
        }
    }
}

struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameView()
    }
}
