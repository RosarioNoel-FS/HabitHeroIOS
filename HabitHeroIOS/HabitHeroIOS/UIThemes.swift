//
//  UIThemes.swift
//  HabitHeroIOS
//
//  Created by Noel Rosario on 12/14/23.
//

import SwiftUI

extension Color {
    static let darkYellow = Color("darkYellow")
    static let buttonText = Color("buttonText")
}

struct RoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.buttonText)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.darkYellow))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}


