import SwiftUI

struct HomeView: View {
    @State private var showEmotionCheckIn = false
    @State private var selectedDayIndex = 2

    @State private var currentMoodValue: CGFloat = 0.6
    @State private var currentFeelings: [String] = ["happy", "energetic"]

    // Animation state
    @State private var illustrationScale: CGFloat = 1.0

    let weekDays = ["Mon 4", "Tue 5", "Wed 6", "Thu 7", "Fri 8", "Sat 9", "Sun 10"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 4) {
                    Text("You are in your")
                        .font(.dsHeadingB20)
                        .foregroundStyle(Color.dsBlack)

                    Text("Ovulation phase")
                        .font(.dsHeadingEB32)
                        .foregroundStyle(Color.greenM)
                }
                .padding(.horizontal)
                .padding(.top)

                HStack(spacing: 10) {
                    ForEach(0..<weekDays.count, id: \.self) { index in
                        dayPill(for: index)
                    }
                }
                .padding(.horizontal)

                ZStack {
                    Image("HomeIllustration")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                        .clipShape(Circle())
                        .scaleEffect(illustrationScale)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 320)
                .onAppear {
                    // Illustration breathes gently, forever
                    withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true).delay(0.6)) {
                        illustrationScale = 1.035
                    }
                }

                Button {
                    showEmotionCheckIn = true
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(Color.purpleD)

                        VStack(alignment: .leading, spacing: 2) {
                            Text("Emotion check-in")
                                .font(.dsHeadingB15)
                                .foregroundStyle(Color.dsBlack)
                            Text("Take some time to do the check-in to understand you better")
                                .font(.dsTextM10)
                                .foregroundStyle(Color.dsTab)
                        }

                        Spacer()
                    }
                    .padding()
                    .background(Color.purpleL)
                    .clipShape(RoundedRectangle(cornerRadius: DSRadius.m))
                    .overlay(
                        RoundedRectangle(cornerRadius: DSRadius.m)
                            .stroke(Color.purpleD.opacity(0.4), lineWidth: 1.5)
                    )
                }
                .padding(.horizontal)

                HStack(alignment: .top, spacing: 12) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Today's Mood + Mind")
                            .font(.dsHeadingB12)
                            .foregroundStyle(Color.dsBlack)

                        HStack {
                            Text(emoji(for: currentMoodValue))
                                .font(.system(size: 24))
                                .frame(width: 44, height: 44)
                                .background(moodCircleColor(for: currentMoodValue))
                                .clipShape(Circle())

                            VStack(alignment: .leading, spacing: 4) {
                                ForEach(currentFeelings, id: \.self) { feeling in
                                    Text(feeling)
                                        .font(.dsTextSB11)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .background(Color.purpleL)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 140, alignment: .center)
                    .background(Color.dsWhite)
                    .clipShape(RoundedRectangle(cornerRadius: DSRadius.m))

                    VStack(spacing: 10) {
                        tipRow(text: "Rise in estrogen during ovulation boosts mood and communication")
                            .padding()
                            .background(Color.dsWhite)
                            .clipShape(RoundedRectangle(cornerRadius: DSRadius.m))

                        tipRow(text: "Energy is on your side today. Take on something meaningful.")
                            .padding()
                            .background(Color.dsWhite)
                            .clipShape(RoundedRectangle(cornerRadius: DSRadius.m))
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .background(Color.dsBackground)
        .sheet(isPresented: $showEmotionCheckIn) {
            EmotionCheckInView { moodValue, feelings in
                currentMoodValue = moodValue
                currentFeelings = Array(feelings)
            }
            .presentationDetents([.height(620)])
            .presentationDragIndicator(.hidden)
            .presentationCornerRadius(DSRadius.m)
        }
    }

    func dayPill(for index: Int) -> some View {
        let isSelected = index == selectedDayIndex
        let parts = weekDays[index].split(separator: " ")

        return VStack(spacing: 4) {
            Text(parts[0])
                .font(.dsCalendarDate)
            Text(parts[1])
                .font(.dsCalendarDateNumber)
        }
        .foregroundStyle(isSelected ? Color.dsWhite : Color.dsTab)
        .frame(width: 42, height: 56)
        .background(isSelected ? Color.greenM : Color.greenL)
        .clipShape(Capsule())
        .onTapGesture {
            selectedDayIndex = index
        }
    }

    func tipRow(text: String) -> some View {
        HStack(alignment: .top, spacing: 6) {
            Image(systemName: "lightbulb.fill")
                .font(.system(size: 12))
                .foregroundStyle(Color.purpleD)

            Text(text)
                .font(.dsTextM10)
                .foregroundStyle(Color.dsTab)
        }
    }

    func emoji(for moodValue: CGFloat) -> String {
        switch moodValue {
        case 0..<0.2: return "😣"
        case 0.2..<0.4: return "🙁"
        case 0.4..<0.6: return "😐"
        case 0.6..<0.8: return "🙂"
        default: return "😊"
        }
    }

    // Matches the exact circle background colors used in EmotionCheckInView's emoji row,
    // so the mood shown on Home is visually consistent with what was picked at check-in.
    func moodCircleColor(for moodValue: CGFloat) -> Color {
        switch moodValue {
        case 0..<0.2: return Color.purpleD.opacity(0.5)
        case 0.2..<0.4: return Color(red: 0.878, green: 0.482, blue: 0.243)
        case 0.4..<0.6: return Color.dsDarkerBg
        case 0.6..<0.8: return Color(red: 0.937, green: 0.788, blue: 0.298)
        default: return Color.greenM
        }
    }
}

#Preview {
    HomeView()
}
