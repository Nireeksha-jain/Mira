//
//  AppColors.swift
//  Beyond_The_Cycle
//
//  Created by Nireeksha Jain Sankighatta Santhosh on 15/7/2026.
//

import SwiftUI

extension Color {
    static let appBackground = Color(hex: 0xF6F0E6)
    static let primaryText = Color(hex: 0x5A493A)
    static let secondaryText = Color(hex: 0x7A6A5E)
    static let brownText = Color(hex: 0x9A7650)
    static let olive = Color(hex: 0x8CA35D)
    static let phaseDay = Color(hex: 0xE3E8D8)
    static let phaseLabel = Color(hex: 0x9B7576)
    static let dayPill = Color(hex: 0xEEEBD2)
    static let warmYellow = Color(hex: 0xF1D88B)
    static let peach = Color(hex: 0xE7BE9D)
    static let softBlue = Color(hex: 0xC9D1D2)
    static let imagePlaceholder = Color(hex: 0xF8F1E5)
    static let lavender = Color(hex: 0xEEE8FF)
    static let purpleAccent = Color(hex: 0xA784FF)
    static let blush = Color(hex: 0xE9DAD8)
    static let sliderTrack = Color(hex: 0xDED6D0)
    static let bubble = Color(hex: 0xE9DECD)

    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
