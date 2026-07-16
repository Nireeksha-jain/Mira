import SwiftUI

struct InsightView: View {
    @State private var selectedTab = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {

                VStack(spacing: 8) {
                    Picker("", selection: $selectedTab) {
                        Text("Sleep").tag(0)
                        Text("Movement").tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    .padding(.top, 8)

                    statCard
                }
                phaseProgressBar
                feelingSection
                tipsSection
            }
            .padding(.bottom, 20)
        }
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color.greenM.opacity(0.6), location: 0.0),
                    .init(color: Color.greenL.opacity(0.6), location: 0.3),
                    .init(color: Color.dsBackground, location: 0.55)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }

    // Figma reference frame width the original design was built at
    let figmaFrameWidth: CGFloat = 393

    var statCard: some View {
        // Fixed scale derived from screen width, computed once — avoids GeometryReader
        // inside ScrollView claiming an oversized, unconstrained height.
        let scale = UIScreen.main.bounds.width / figmaFrameWidth

        return ZStack(alignment: .topLeading) {

                // Tip card: Figma X=15 Y=223 W=370 H=101, corner radius 24, opacity 65%
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "lightbulb.fill")
                        .foregroundStyle(Color.greenM)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(selectedTab == 0 ? "Rise in estrogen delays sleep onset. Wind down earlier and aim for >8 hours of sleep tonight." : "Ovulation is your peak strength window. Low step count so far (1,500). ")
                            .font(.dsHeadingB15)
                            .foregroundStyle(Color.dsBlack)
                            .fixedSize(horizontal: false, vertical: true)
//
//                        Text(selectedTab == 0
//                             ? "Takes you longer to fall asleep. Wind down earlier and aim for >8 hours of sleep tonight"
//                             : "Low step count so far (1,500). Your body is ready for more!")
//                            .font(.dsTextM10)
//                            .foregroundStyle(Color.dsTab)
//                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(width: 130 * scale, alignment: .leading) // stays clear of the illustration's left edge (x=161)
                    Spacer(minLength: 0)
                }
                .padding(12)
                .frame(width: 370 * scale, height: 101 * scale, alignment: .topLeading)
                .background(Color.dsWhite.opacity(0.65))
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .offset(x: 15 * scale, y: (223 - 91) * scale) // baseline-corrected: illustration's Y=91 is our local y=0

                // Illustration: Figma X=161 Y=91 W=232 H=264.32 — right-edge flush to frame
                Group {
                    if selectedTab == 1 {
                        Image("MovementIllustration")
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image("MovementIllustration")
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(width: 232 * scale, height: 264.32 * scale)
                .clipped()
                .offset(x: 161 * scale, y: 0)

                // Stat pill: Figma X=15 Y=114 W=180 H=92
                HStack(spacing: 10) {
                    Image(systemName: selectedTab == 0 ? "moon.zzz.fill" : "figure.walk")
                        .font(.system(size: 18))
                        .foregroundStyle(Color.greenM)
                        .frame(width: 36, height: 36)
                        .background(Color.greenL)
                        .clipShape(Circle())

                    if selectedTab == 0 {
                        (Text("6h 10").font(.dsHeadingEB32.weight(.bold))
                         + Text("\nsleep duration").font(.dsTextM10))
                    } else {
                        (Text("1500").font(.dsHeadingEB32.weight(.bold))
                         + Text("\nsteps so far").font(.dsTextM10))
                    }
                }
                .foregroundStyle(Color.dsBlack)
                .padding(.horizontal, 12)
                .frame(width: 180 * scale, height: 92 * scale)
                .background(Color.dsWhite)
                .clipShape(RoundedRectangle(cornerRadius: DSRadius.m))
                .offset(x: 15 * scale, y: (114 - 91) * scale) // baseline-corrected: illustration's Y=91 is our local y=0
                // Decorative sparkle icons for Sleep tab
                if selectedTab == 0 {
                    sparkleIcon(x: 10 * scale, y: 10 * scale, size: 16)
                    sparkleIcon(x: 195 * scale, y: 145 * scale, size: 14)
                }

        }
        .frame(width: UIScreen.main.bounds.width, height: 234 * scale)
        .clipped()
    }

    func leafIcon(x: CGFloat, y: CGFloat, size: CGFloat) -> some View {
        Image(systemName: "leaf.fill")
            .font(.system(size: size * 0.5))
            .foregroundStyle(Color.greenH)
            .frame(width: size, height: size)
            .background(Circle().stroke(Color.greenH.opacity(0.4), lineWidth: 1))
            .offset(x: x, y: y)
    }

    func sparkleIcon(x: CGFloat, y: CGFloat, size: CGFloat) -> some View {
        Image(systemName: "sparkle")
            .font(.system(size: size))
            .foregroundStyle(Color.dsWhite.opacity(0.8))
            .offset(x: x, y: y)
    }

    var phaseProgressBar: some View {
        VStack(spacing: 6) {
            GeometryReader { geo in
                let dotSize: CGFloat = 18
                let badgeSize: CGFloat = 30
                let spacing: CGFloat = 8
                let remaining = geo.size.width - dotSize - badgeSize - (spacing * 3)
                let blueWidth = remaining * 0.6
                let yellowWidth = remaining * 0.4

                HStack(spacing: spacing) {
                    Circle()
                        .fill(Color.cycleRed)
                        .frame(width: dotSize, height: dotSize)

                    Capsule()
                        .fill(Color.cycleBlue)
                        .frame(width: blueWidth, height: 16)

                    Circle()
                        .stroke(Color.greenM, lineWidth: 2)
                        .background(Circle().fill(Color.dsWhite))
                        .frame(width: badgeSize, height: badgeSize)
                        .overlay(Text("21").font(.dsTextSB11).foregroundStyle(Color.greenM))

                    Capsule()
                        .fill(Color.cycleYellow)
                        .frame(width: yellowWidth, height: 16)
                }
                .frame(width: geo.size.width, height: badgeSize)
            }
            .frame(height: 30)
            .padding(.horizontal, 50)

            (
                Text("You are in your ")
                    .foregroundStyle(Color.dsTab)
                    .fontWeight(.bold)
                + Text("Ovulation")
                    .foregroundStyle(Color.greenM)
                    .fontWeight(.bold)
                + Text(" phase")
                    .foregroundStyle(Color.dsTab)
                    .fontWeight(.bold)
            )
            .font(.system(size: 14, weight: .bold))
        }
        .padding(.horizontal)
    }

    var feelingSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("You might be feeling ...")
                .font(.dsHeadingB15)
                .foregroundStyle(Color.greenH)
                .padding(.horizontal)

            ZStack {
                if selectedTab == 1 {
                    feelingBubble("Agile", size: 65, x: -35, y: -45)
                    feelingBubble("Strong", size: 70, x: 85, y: -40)
                    feelingBubble("Balanced", size: 78, x: -85, y: 30)
                    feelingBubble("Quick Recovery", size: 95, x: 15, y: 25)
                } else {
                    feelingBubble("Refreshed", size: 78, x: -45, y: -35)
                    feelingBubble("Light sleeper", size: 82, x: 78, y: -40)
                    feelingBubble("Alert", size: 60, x: -68, y: 45)
                    feelingBubble("Well Rested", size: 88, x: 35, y: 45)
                }
            }
            .frame(height: 160)
            .frame(maxWidth: .infinity)
        }
    }

    enum BubbleShape { case circle, cloud }

    func feelingBubble(_ title: String, size: CGFloat, x: CGFloat, y: CGFloat, shape: BubbleShape = .circle) -> some View {
        Group {
            if shape == .circle {
                Circle()
                    .fill(Color.greenM.opacity(0.85))
                    .frame(width: size, height: size)
                    .overlay(
                        Text(title)
                            .font(.dsTextSB11)
                            .foregroundStyle(Color.dsWhite)
                            .multilineTextAlignment(.center)
                            .padding(6)
                    )
            } else {
                RoundedRectangle(cornerRadius: size / 2.5)
                    .fill(Color.greenM.opacity(0.85))
                    .frame(width: size, height: size * 0.65)
                    .overlay(
                        Text(title)
                            .font(.dsTextSB11)
                            .foregroundStyle(Color.dsWhite)
                            .multilineTextAlignment(.center)
                            .padding(6)
                    )
            }
        }
        .offset(x: x, y: y)
    }

    var tipsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Tips for you :")
                .font(.dsHeadingB15)
                .foregroundStyle(Color.greenH)
                .padding(.horizontal)

            if selectedTab == 0 {
                tipRow(icon: "figure.walk", text: "Try light stretching before bed to help you relax after exercising today")
                tipRow(icon: "lightbulb.fill", text: "Avoid caffeine after 2 PM and start winding down by 9:30 PM, earlier than usual")
            } else {
                tipRow(icon: "figure.run", text: "Aim for a 20-30 minute cardio session — a brisk walk, jog, or yoga flow works well")
                tipRow(icon: "figure.strengthtraining.traditional", text: "Your body is primed for strength today. Ovulation is a great window for resistance training")
            }
        }
    }

    func tipRow(icon: String, text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(Color.greenM)
                .frame(width: 20, height: 20)
                .padding(.top, 2)

            Text(text)
                .font(.system(size: 13))
                .foregroundStyle(Color.dsBlack)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.greenL)
        .clipShape(RoundedRectangle(cornerRadius: DSRadius.s))
        .overlay(
            RoundedRectangle(cornerRadius: DSRadius.s)
                .stroke(Color.greenM.opacity(0.4), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

#Preview {
    InsightView()
}
