//
//  Theme.swift
//  Features
//
//  Created by Stuart Minchington on 5/1/25.
//

import SwiftUI

struct SauceColors {
    static let background = Color(red: 0.1, green: 0.1, blue: 0.1) // Midnight
    static let accent = Color(red: 0.0, green: 0.8, blue: 0.2) // Sauce Green
    static let textPrimary = Color.white
    static let textSecondary = Color.gray
    static let secondaryBackground = Color(red: 0.15, green: 0.15, blue: 0.15)
}

struct SauceTypography {
    static let headerFont: Font = .system(.headline, design: .monospaced).weight(.bold)
    static let subHeaderFont: Font = .system(.subheadline, design: .monospaced)
    static let bodyFont: Font = .system(.body, design: .monospaced) // Keep mono for dev feel
    static let captionFont: Font = .system(.caption, design: .monospaced)
}

// Extend View to easily apply the background
extension View {
    func sauceBackground() -> some View {
        self.background(SauceColors.background)
            .preferredColorScheme(.dark) // Force dark mode
    }
}

// Custom Button Style
struct SauceButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(SauceTypography.bodyFont)
            .padding()
            .background(SauceColors.accent.opacity(configuration.isPressed ? 0.7 : 1.0))
            .foregroundColor(.black) // High contrast on green
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
