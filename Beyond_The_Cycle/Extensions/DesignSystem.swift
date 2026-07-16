//
//  DesignSystem.swift
//  Beyond_The_Cycle
//
//  Created by Nireeksha Jain Sankighatta Santhosh on 16/7/2026.
//

import SwiftUI

// MARK: - Design tokens, matching Figma "02 Variable collection" exactly
// Reference: system, cycle, green, purple, emoji, root groups

extension Color {

    // MARK: system
    static let dsWhite = Color(hex: 0xFFFFFF)
    static let dsBackground = Color(hex: 0xF5F0E8)
    static let dsDarkerBg = Color(hex: 0xE9DECD)
    static let dsTab = Color(hex: 0x98825F)
    static let dsBlack = Color(hex: 0x4F3422)

    // MARK: cycle
    static let cycleRed = Color(hex: 0xE1C0A5)      // Menstrual Phase
    static let cycleBlue = Color(hex: 0xC5CACD)      // Follicular Phase
    static let cycleGreen = Color(hex: 0xA7B389)     // Ovulation Phase
    static let cycleYellow = Color(hex: 0xEED6A9)    // Luteal Phase

    // MARK: green
    static let greenL = Color(hex: 0xDFE0C8)
    static let greenM = Color(hex: 0x9BB167)
    static let greenH = Color(hex: 0x5D5E48)

    // MARK: purple
    static let purpleL = Color(hex: 0xEDE9FE)
    static let purpleD = Color(hex: 0xA788FA)
    static let purpleH = Color(hex: 0x5D2AAD)

    // MARK: emoji
    static let emojiOrange = Color(hex: 0xFB8728)
    static let emojiYellow = Color(hex: 0xFAC815)

    // MARK: root
    static let dsBgOpacity65 = Color(hex: 0xFFFFFF, opacity: 0.65)
    static let dsTabFill = Color(hex: 0xE3E3E3)
}

// MARK: - Radius set (04 Radius Set)
enum DSRadius {
    static let xs: CGFloat = 8     // compact icons, tiny controls, small indicators
    static let s: CGFloat = 14     // date cells, chips, compact inputs, small cards
    static let m: CGFloat = 24     // primary buttons, cards, notifications, modals
    static let full: CGFloat = 999 // pills, circular badges, avatars, fully rounded controls
}

// MARK: - Text styles (01 Text styles)
// Font "Urbanist" must be added to the project (imported .ttf files + Info.plist entry)
// for these to render in the correct typeface. Falls back to system font if not installed.
extension Font {
    static let dsHeadingEB32 = Font.custom("Urbanist-ExtraBold", size: 32) // tracking -1.5%
    static let dsHeadingB20 = Font.custom("Urbanist-Bold", size: 20)       // tracking 0%
    static let dsHeadingB15 = Font.custom("Urbanist-Bold", size: 15)       // tracking -0.2%
    static let dsHeadingB12 = Font.custom("Urbanist-Bold", size: 12)       // tracking -0.2%

    static let dsTextSB11 = Font.custom("Urbanist-SemiBold", size: 11)     // tracking -0.2%
    static let dsTextM10 = Font.custom("Urbanist-Medium", size: 10)        // tracking -0.2%

    static let dsCalendarDate = Font.custom("Urbanist-Bold", size: 10)         // tracking -0.15%
    static let dsCalendarDateNumber = Font.custom("Urbanist-ExtraBold", size: 15) // tracking -0.5%
}

// MARK: - Drop shadow (03 Effect style)
extension View {
    func dsDropShadow() -> some View {
        self.shadow(color: Color.black.opacity(0.05), radius: 16, x: 0, y: 8)
    }
}
