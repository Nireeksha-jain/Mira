import SwiftUI

struct EmotionCheckInView: View {

    // MARK: - Properties

    @Environment(\.dismiss) var dismiss

    // Callback fires when user taps Done, passing selected mood data back to whoever presented this sheet
    var onComplete: ((CGFloat, Set<String>) -> Void)? = nil

    @State private var moodValue: CGFloat = 0.5
    @State private var stressValue: CGFloat = 0.85
    @State private var selectedFeelings: Set<String> = []
    @State private var selectedStressors: Set<String> = []


    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.clear
            sheet
        }
    }
}


// MARK: - Mood Section

extension EmotionCheckInView {

    var moodSection: some View {

        VStack(alignment: .leading, spacing: 18) {

            Text("How are you feeling today?")
                .font(.dsHeadingB15)
                .foregroundStyle(Color.dsBlack)

            CustomSlider(value: $moodValue)

            HStack {
                emotionCircle(emoji: "😣", background: Color.purpleD.opacity(0.5))
                Spacer()
                emotionCircle(emoji: "🙁", background: Color(red: 0.878, green: 0.482, blue: 0.243))
                Spacer()
                emotionCircle(emoji: "😐", background: Color.dsDarkerBg)
                Spacer()
                emotionCircle(emoji: "🙂", background: Color(red: 0.937, green: 0.788, blue: 0.298))
                Spacer()
                emotionCircle(emoji: "😊", background: Color.greenM)
            }
        }
    }

    func emotionCircle(emoji: String, background: Color) -> some View {
        Text(emoji)
            .font(.system(size: 18))
            .frame(width: 35, height: 35)
            .background(background)
            .clipShape(Circle())
    }
}


// MARK: - Emotion Custom Slider

struct CustomSlider: View {
    @Binding var value: CGFloat

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.dsDarkerBg)
                    .frame(height: 8)

                Capsule()
                    .fill(Color.greenM)
                    .frame(width: value * geo.size.width, height: 8)

                Circle()
                    .fill(Color.greenM)
                    .frame(width: 34, height: 34)
                    .shadow(color: Color.greenM.opacity(0.25), radius: 12, y: 3)
                    .overlay {
                        Circle().stroke(.white, lineWidth: 6)
                    }
                    .offset(x: value * (geo.size.width - 34))
                    .gesture(
                        DragGesture()
                            .onChanged { drag in
                                value = min(max(drag.location.x / geo.size.width, 0), 1)
                            }
                    )
            }
        }
        .frame(height: 34)
    }
}

// MARK: - Bottom Sheet

extension EmotionCheckInView {
    var sheet: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    Capsule()
                        .fill(Color.greenM)
                        .frame(width: 48, height: 5)
                        .padding(.top, 8)
                        .padding(.bottom, 12)

                    HStack {
                        Spacer()
                        closeButton
                    }
                    .padding(.top, -10)

                    moodSection
                    stressSection
                    bodyFeelingSection
                    stressBubbleSection
                    DoneButton
                }
                .padding(.horizontal, 18)
                .padding(.top, 22)
                .padding(.bottom, 40)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.dsBackground)
        .clipShape(RoundedRectangle(cornerRadius: DSRadius.m))
    }
}

// MARK: - Stress Section

extension EmotionCheckInView {

    var stressSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Stress level today")
                .font(.dsHeadingB15)
                .foregroundStyle(Color.dsBlack)

            CustomSlider(value: $stressValue)

            HStack {
                Text("1")
                Spacer()
                Text("2")
                Spacer()
                Text("3")
                Spacer()
                Text("4")
                Spacer()
                Text("5")
            }
            .font(.system(size: 15, weight: .medium))
            .foregroundColor(Color.dsTab)
        }
    }
}

// MARK: - Body Feeling Section

extension EmotionCheckInView {

    var bodyFeelingSection: some View {
        VStack(alignment: .leading, spacing: 19) {
            Text("Body noticing anything?")
                .font(.dsHeadingB15)
                .foregroundStyle(Color.dsBlack)

            HStack(spacing: 7) {
                feelingButton("Energized")
                feelingButton("Low Energy")
                feelingButton("Restless")
            }
        }
    }
}

// MARK: - Feeling Button

extension EmotionCheckInView {

    func feelingButton(_ title: String) -> some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                if selectedFeelings.contains(title) {
                    selectedFeelings.remove(title)
                } else {
                    selectedFeelings.insert(title)
                }
            }
        } label: {
            HStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                Image(systemName: selectedFeelings.contains(title) ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 18, weight: .semibold))
            }
            .foregroundStyle(selectedFeelings.contains(title) ? .white : .primaryText)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .padding(.horizontal, 8)
            .background(selectedFeelings.contains(title) ? Color.greenM : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: DSRadius.m))
            .shadow(color: .black.opacity(0.08), radius: 10, y: 5)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Stress Bubble Section

extension EmotionCheckInView {

    var stressBubbleSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Select Stressors")
                .font(.dsHeadingB15)
                .foregroundStyle(Color.dsBlack)
                .offset(x: -110)

            ZStack {
                stressBubble(title: "Relationship", size: 95, x: -130, y: -25)
                stressBubble(title: "Work", size: 60, x: -55, y: -95)
                stressBubble(title: "Travel", size: 62, x: 75, y: -85)
                stressBubble(title: "Finance", size: 78, x: 130, y: -10)
                stressBubble(title: "Kids", size: 60, x: -80, y: 85)
                stressBubble(title: "School", size: 55, x: 80, y: 85)
                stressBubble(title: "Health", size: 140, x: 0, y: 3)
            }
            .frame(height: 235)
        }
    }
}

// MARK: - Stress Bubble

extension EmotionCheckInView {

    func stressBubble(title: String, size: CGFloat, x: CGFloat, y: CGFloat) -> some View {
        let selected = selectedStressors.contains(title)

        return Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                if selected {
                    selectedStressors.remove(title)
                } else {
                    selectedStressors.insert(title)
                }
            }
        } label: {
            Circle()
                .fill(selected ? Color.greenM : Color.greenL)
                .frame(width: size, height: size)
                .overlay {
                    Text(title)
                        .font(.system(size: size > 120 ? 15 : 13, weight: .semibold))
                        .foregroundStyle(selected ? Color.white : Color.dsTab)
                }
                .shadow(color: .black.opacity(0.08), radius: 10, y: 5)
        }
        .buttonStyle(.plain)
        .scaleEffect(selected ? 1.05 : 1.0)
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: selected)
        .offset(x: x, y: y)
    }
}

// MARK: - Done Button

extension EmotionCheckInView {

    var DoneButton: some View {
        Button {
            // Pass mood value + selected feelings back to whoever presented this sheet
            onComplete?(moodValue, selectedFeelings)
            dismiss()
        } label: {
            Text("Done")
                .font(.dsHeadingB15)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(Color.greenM)
                .clipShape(RoundedRectangle(cornerRadius: DSRadius.m))
                .shadow(color: .black.opacity(0.12), radius: 12, y: 6)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Close Button

extension EmotionCheckInView {

    var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(Color.dsBlack)
                .frame(width: 44, height: 44)
                .contentShape(Circle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

#Preview {
    EmotionCheckInView()
}
