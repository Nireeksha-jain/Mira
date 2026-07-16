//
//  ReminderPopUp.swift
//  Beyond_The_Cycle
//
//  Created by Nireeksha Jain Sankighatta Santhosh on 15/7/2026.
//

import SwiftUI

struct ReminderPopupView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.35)
                .ignoresSafeArea()
            reminderCard
        }
    }
}

extension ReminderPopupView {
    var reminderCard: some View {
        VStack(spacing: 28) {
            titleSection
            subtitleSection
            laterButton
            doNowButton
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 35)
        .frame(width: 340)
        .background(Color(red: 249/255, green: 245/255, blue: 239/255))
        .cornerRadius(30)
        .shadow(color: .black.opacity(0.12), radius: 20, y: 8)
    }
}

extension ReminderPopupView {
    var titleSection: some View {
        Text("Do you want to\ncheck in later?")
            .font(.system(size: 28, weight: .bold))
            .foregroundStyle(Color(red: 93/255, green: 69/255, blue: 54/255))
            .multilineTextAlignment(.center)
            .padding(.top, 10)
    }
}

extension ReminderPopupView {
    var subtitleSection: some View {
        Text("You can always complete your\ndaily check-in from the Home screen.")
            .font(.system(size: 17))
            .foregroundStyle(.gray)
            .multilineTextAlignment(.center)
            .lineSpacing(3)
    }
}

extension ReminderPopupView {
    var laterButton: some View {
        Button {
            print("Later tapped")
        } label: {
            Text("I'll do it later")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(Color(red: 163/255, green: 184/255, blue: 110/255))
                .cornerRadius(18)
        }
    }
}

extension ReminderPopupView {
    var doNowButton: some View {
        Button {
            print("Do it now tapped")
        } label: {
            Text("No, I will do it now")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color(red: 163/255, green: 184/255, blue: 110/255))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color(red: 163/255, green: 184/255, blue: 110/255), lineWidth: 2)
                )
                .cornerRadius(18)
        }
    }
}

#Preview {
    ReminderPopupView()
}
